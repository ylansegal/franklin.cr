require "./spec_helper"

describe Franklin do
  it "has a version number" do
    expect(Franklin::VERSION).not_to be_nil
  end

  describe ".run" do
    let(:example_config_path) { File.join(__DIR__, "example_franklin_config.yml") }
    let(:response_body) { File.read("spec/seveneves_search.html") }

    it "integrates end-to-end" do
      # Recorded search, replayed to avoid network traffic in testing
      WebMock.stub(:get, "https://sfpl.overdrive.com/search?query=Seveneves")
             .to_return(body: response_body)
      WebMock.stub(:get, "https://sdpl.overdrive.com/search?query=Seveneves")
             .to_return(body: response_body)

      expect {
        Franklin.run(search_terms: "Seveneves",
          config_path: example_config_path,
          filter: nil,
          io: IO::Memory.new)
      }.not_to raise_error
    end
  end
end
