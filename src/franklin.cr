require "./franklin/*"

module Franklin
  def self.run(search_terms : String, config_path : String, type : String | Nil, io : IO = STDOUT, connection = nil)
    config = Config.from_file(config_path)
    per_library_results = config.libraries.map { |library|
      Search.new(library).perform(search_terms, connection)
    }
    results = Collate.new.perform(per_library_results)
    filtered_results = TypeFilter.new(type || config.default_type).perform(results)
    ConsoleReport.new(search_terms, filtered_results).to_s(io)
  end
end
