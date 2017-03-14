# require "cossack"
require "http/client"
require "xml"
require "json"

module Franklin
  class Search
    JS_VARIABLE = /window\.OverDrive\.mediaItems/

    property library : Library

    def initialize(@library)
    end

    def search_url(search_terms : String) : String
      URI.parse(library.url).tap { |uri|
        uri.path = "/search"
        uri.query = HTTP::Params.build { |params| params.add("query", search_terms) }
      }.to_s
    end

    def perform(search_terms : String) : Hash(Item, Availability)
      results_page = search_library(search_terms)
      results_json = extract_json(results_page)
      parse(results_json)
    end

    private def search_library(search_terms : String)
      response = HTTP::Client.get(search_url(search_terms))
      XML.parse(response.body)
    end

    private def extract_json(result_page : XML::Node)
      script_tag = result_page.xpath_nodes("//script").map(&.content).select { |n| n =~ JS_VARIABLE }.first
      var_assignment_line = script_tag.lines.find { |line| line =~ JS_VARIABLE }
      matches = var_assignment_line.scan(/{.*}/).[0]? if var_assignment_line
      raw_javascript_object = matches[0]? if matches
      "{ \"data\": #{raw_javascript_object}}" if raw_javascript_object
    end

    private def parse(json : Nil)
      {} of Item => Availability
    end

    private def parse(raw_data : String)
      result = {} of Item => Availability
      Overdrive::Data.from_json(raw_data).data.each do |id, oitem|
        item = Franklin::Item.new(id, oitem.title, oitem.firstCreatorName, oitem.type.name)
        availability = Franklin::Availability.new(library, oitem.ownedCopies, oitem.availableCopies, oitem.holdsCount)
        result[item] = availability
      end
      result
    end
  end

  module Overdrive
    struct Data
      JSON.mapping(
        data: Hash(String, Overdrive::Item)
      )
    end

    struct Item
      JSON.mapping(
        title: String,
        firstCreatorName: String,
        type: Type,
        ownedCopies: { type: Int32, default: 0 },
        availableCopies: { type: Int32, default: 0 },
        holdsCount: { type: Int32, default: 0 }
      )
    end

    struct Type
      JSON.mapping(
        name: String
      )
    end
  end
end
