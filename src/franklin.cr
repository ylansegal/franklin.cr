require "./franklin/*"

module Franklin
  def self.run(search_terms : String, config_path : String, filter : String | Nil, io : IO = STDOUT)
    config = Config.from_file(config_path)
    per_library_results = ConcurrentSearch(Search).new(config.libraries).perform(search_terms)
    results = Collate.new.perform(per_library_results)
    filtered_results = TypeFilter.new(filter || config.default_type).perform(results)
    ConsoleReport.new(search_terms, filtered_results).to_s(io)
  end
end
