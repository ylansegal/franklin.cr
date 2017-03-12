require "cossack"
require "xml"
require "json"

module Franklin
  class Search
    JS_VARIABLE = /window\.OverDrive\.mediaItems/

    property library : Library

    def initialize(@library)
    end

    def perform(search_term : String, connection = nil) : Hash(Item, Availability)
      results_page = search_library(search_term, connection)
      results_json = extract_json(results_page)
      parse(results_json)
    end

    private def search_library(search_terms : String, connection)
      client.connection = connection if connection
      response = client.get(search_path(search_terms))
      doc = XML.parse(response.body)
    end

    private def extract_json(result_page : XML::Node)
      script_tag = result_page.xpath_nodes("//script").map(&.content).select { |n| n =~ JS_VARIABLE }.first
      var_assignment_line = script_tag.lines.find { |line| line =~ JS_VARIABLE }
      raw_javascript_object = var_assignment_line.scan(/{.*}/).first[0] if var_assignment_line
      JSON.parse(raw_javascript_object) if raw_javascript_object
    end

    def parse(json : Nil)
      {} of Item => Availability
    end

    def parse(json : JSON::Any)
      result = {} of Item => Availability
      json.each { |id, data|
        result[parse_item(id.as_s, data)] = parse_availability(data)
      }
      result
    end

    def parse_item(id, data)
      Item.new(id, data["title"].as_s, data["firstCreatorName"].as_s, data["type"]["name"].as_s)
    end

    def parse_availability(data)
      Availability.new(library, data["ownedCopies"].as_i, data["availableCopies"].as_i, data["holdsCount"].as_i)
    end

    private def client
      @client ||= Cossack::Client.new(library.url) { |client|
        client.use Cossack::RedirectionMiddleware
      }
    end

    private def search_path(search_terms : String)
      params = HTTP::Params.build do |form|
        form.add("query", search_terms)
      end

      "/search?#{params}"
    end
  end
end
