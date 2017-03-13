require "../spec_helper"

module Franklin
  describe Search do
    context "#perform" do
      subject { Search.new(library) }
      let(:library) { Library.fixture }
      let(:results) { subject.perform(search_term) }
      let(:items) { results.keys }
      let(:search_term) { "Prelude to Foundation" }
      let(:response_body) { File.read("spec/prelude_to_foundation_search.html") }

      it "returns expected results" do
        # These results where known to be accurate when this test was recorded.
        # To update test, modify the contents of spec/prelude_to_foundation_search.html
        WebMock.stub(:get, "#{library.url}/search?query=Prelude+to+Foundation")
               .to_return(status: 200, body: response_body)

        expect(items.map(&.format).sort).to eq(["eBook", "Audiobook"].sort)
        expect(items.map(&.title).first).to match(/#{search_term}/)
        expect(items.map(&.author).first).to eq("Isaac Asimov")
      end
    end
  end
end
