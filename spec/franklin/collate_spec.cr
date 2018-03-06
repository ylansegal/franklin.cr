require "../spec_helper"

module Franklin
  describe Collate do
    let(:results) { Collate.new.perform([search_results_1, search_results_2]) }

    describe "#perform (combines multiple search results)" do
      let(:search_results_1) {
        {
          item_1 => availability_1,
          item_2 => availability_2,
        }
      }
      let(:search_results_2) {
        {
          item_2 => availability_3,
          item_3 => availability_4,
        }
      }
      let(:item_1) { Item.random_fixture }
      let(:item_2) { Item.random_fixture }
      let(:item_3) { Item.random_fixture }
      let(:availability_1) { Availability.random_fixture }
      let(:availability_2) { Availability.random_fixture(1) }
      let(:availability_3) { Availability.random_fixture(0) }
      let(:availability_4) { Availability.random_fixture }

      it "includes all items and their availabilities" do
        expect(results).to eq({
          item_1 => [availability_1],
          item_2 => [availability_2, availability_3],
          item_3 => [availability_4],
        })
      end
    end

    context "ordering of availabilities" do
      let(:results) { Collate.new.perform([search_results_1, search_results_2, search_results_3]) }
      let(:search_results_1) { { item_1 => availability_3 } }
      let(:search_results_2) { { item_1 => availability_1 } }
      let(:search_results_3) { { item_1 => availability_2 } }
      let(:item_1) { Item.random_fixture }
      let(:availability_1) { Availability.new(Library.random_fixture, 10, 3, 0) }
      let(:availability_2) { Availability.new(Library.random_fixture, 20, 0, 4) }
      let(:availability_3) { Availability.new(Library.random_fixture, 10, 0, 3) }

      it "shows available copies first, then by copies per person" do
        expect(results).to eq({
          item_1 => [availability_1, availability_2, availability_3]
        })
      end
    end
  end
end
