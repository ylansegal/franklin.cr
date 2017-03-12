require "../spec_helper"

module Franklin
  describe Search do
    context "#perform" do
      subject { Search.new(library) }
      let(:library) { Library.fixture }
      let(:results) { subject.perform(search_term, test_connection) }
      let(:items) { results.keys }
      let(:search_term) { "Prelude to Foundation" }
      let(:test_connection) { Cossack::TestConnection.new.tap { |con|
          con.stub_get("/search", {200, File.read("spec/prelude_to_foundation_search.html")})
        }
      }

      it "returns expected results" do
        # These results where known to be accurate when this test was recorded.
        # To update test, modify the contents of spec/prelude_to_foundation_search.html
        expect(items.map(&.format).sort).to eq(["eBook", "Audiobook"].sort)
        expect(items.map(&.title).first).to match(/#{search_term}/)
        expect(items.map(&.author).first).to eq("Isaac Asimov")
      end
    end
  end
end
