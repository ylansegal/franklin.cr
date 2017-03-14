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

    def perform(search_term : String) : Hash(Item, Availability)
      results_page = search_library(search_term)
      results_json = extract_json(results_page)
      parse(results_json)
    end

    private def search_library(search_terms : String)
      response = HTTP::Client.get(search_url(search_terms))
      XML.parse(response.body)
    end

    private def search_url(search_terms)
      URI.parse(library.url).tap { |uri|
        uri.path = "/search"
        uri.query = HTTP::Params.build { |params| params.add("query", search_terms) }
      }
    end

    private def extract_json(result_page : XML::Node)
      script_tag = result_page.xpath_nodes("//script").map(&.content).select { |n| n =~ JS_VARIABLE }.first
      var_assignment_line = script_tag.lines.find { |line| line =~ JS_VARIABLE }
      matches = var_assignment_line.scan(/{.*}/).[0]? if var_assignment_line
      raw_javascript_object = matches[0]? if matches
      JSON.parse(raw_javascript_object) if raw_javascript_object
    end

    private def parse(json : Nil)
      {} of Item => Availability
    end

    private def parse(json : JSON::Any)
      result = {} of Item => Availability
      json.each { |id, data|
        result[parse_item(id.as_s, data)] = parse_availability(data)
      }
      result
    end

    private def parse_item(id, data)
      Item.new(id, data["title"].as_s, data["firstCreatorName"].as_s, data["type"]["name"].as_s)
    end

    private def parse_availability(data)
      Availability.new(library,
                       extract(data, "ownedCopies"),
                       extract(data, "availableCopies"),
                       extract(data, "holdsCount"))
    end

    private def extract(data, key)
      json_to_i(data[key]?)
    end

    private def json_to_i(json : JSON::Any)
      json.as_i
    end

    private def json_to_i(json : Nil)
      0
    end
  end
end
