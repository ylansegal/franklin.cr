require "./spec_helper"

describe Franklin do
  it "has a version number" do
    Franklin::VERSION.should_not be_nil
  end

  describe ".run" do
    it "integrates end-to-end" do
      example_config_path = File.join(__DIR__, "example_franklin_config.yml")
      response_body = File.read("spec/seveneves_search.html")

      # Recorded search, replayed to avoid network traffic in testing
      WebMock.stub(:get, "https://sfpl.overdrive.com/search?query=Seveneves")
             .to_return(body: response_body)
      WebMock.stub(:get, "https://sdpl.overdrive.com/search?query=Seveneves")
             .to_return(body: response_body)

      Franklin.run(search_terms: "Seveneves",
        config_path: example_config_path,
        filter: nil,
        io: IO::Memory.new)
    end
  end
end
