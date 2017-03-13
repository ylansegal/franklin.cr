require "./franklin/*"

module Franklin
  def self.run(search_terms, opts)
    config = Config.from_file(opts.fetch(:config_path, nil))
    per_library_results = config.libraries.map { |library|
      Search.new(library).perform(search_terms)
    }
    results = Collate.new.perform(per_library_results)
    filtered_results = TypeFilter.new(opts.fetch(:type, nil)).perform(results)
    ConsoleReport.new(search_terms, filtered_results).to_s(STDOUT)
  end
end
