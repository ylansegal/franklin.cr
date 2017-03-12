require "../spec_helper"

module Franklin
  describe Search do
    context "#perform" do
      subject { Search.new(library) }
      let(:library) { Library.fixture }
      let(:results) { subject.perform(search_term) }
      let(:items) { results.keys }
      let(:search_term) { "Prelude to Foundation" }

      it "returns expected results" do
        # These results where known to be accurate when this test was created.
        # The should be recorded
        expect(items.map(&.format).sort).to eq(["eBook", "Audiobook"].sort)
        expect(items.map(&.title).first).to match(/#{search_term}/)
        expect(items.map(&.author).first).to eq("Isaac Asimov")
      end
    end
  end
end
