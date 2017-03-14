require "../spec_helper"

module Franklin
  describe Search do
    subject { Search.new(library) }
    let(:library) { Library.fixture }
    let(:search_terms) { "Prelude to Foundation" }

    context "#perform" do
      let(:results) { subject.perform(search_terms) }
      let(:items) { results.keys }
      let(:response_body) { File.read("spec/prelude_to_foundation_search.html") }

      before {
        WebMock.reset
        # These results where known to be accurate when this test was recorded.
        # To update test, modify the contents of spec/*_search.html
        WebMock.stub(:get, "#{library.url}/search?query=Prelude+to+Foundation")
               .to_return(status: 200, body: response_body)
      }

      it "returns expected results" do
        expect(items.map(&.format).sort).to eq(["eBook", "Audiobook"].sort)
        expect(items.map(&.title).first).to match(/#{search_terms}/)
        expect(items.map(&.author).first).to eq("Isaac Asimov")
      end

      context "when unreadable json is returned from server" do
        let(:response_body) { File.read("spec/bad_search.html") }

        it "returns empty results" do
          expect(results.empty?).to be_true
        end
      end
    end

    context "search_url" do
      let(:search_url) { subject.search_url(search_terms) }

      it "appends the search path and query" do
        expect(search_url).to eq("#{library.url}/search?query=Prelude+to+Foundation")
      end

      context "when a libarary contains an ending /" do
        let(:url) { "https://alexandria.org/" }
        let(:expected_url) { "https://alexandria.org/search?query=Prelude+to+Foundation" }
        let(:library) { Library.new("Library Of Alexandria", url) }

        it "handles setting the path without repeating /" do
          expect(search_url).to eq(expected_url)
        end
      end
    end
  end
end
