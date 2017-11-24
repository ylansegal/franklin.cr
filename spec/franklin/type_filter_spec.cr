require "../spec_helper"

module Franklin
  describe TypeFilter do
    subject { TypeFilter.new(type) }
    let(:results) {
      {
        item_1 => [availability_1],
        item_2 => [availability_2],
      }
    }
    let(:item_1) { Item.random_fixture(item_type) }
    let(:item_2) { Item.random_fixture }
    let(:availability_1) { Availability.random_fixture }
    let(:availability_2) { Availability.random_fixture }
    let(:type) { "holobook" }
    let(:item_type) { type }
    let(:filtered_results) { subject.perform(results) }

    it "filters results for a given type" do
      expect(filtered_results).to eq({item_1 => [availability_1]})
    end

    context "when type is in different case" do
      let(:type) { "HoLoBOOK" }

      it "filters results" do
        expect(filtered_results).to eq({item_1 => [availability_1]})
      end
    end

    context "when the type is nil" do
      let(:type) { nil }
      let(:item_type) { "VCR_Tape" }

      it "returns unmodified results" do
        expect(filtered_results).to eq(results)
      end
    end
  end
end
