require "../spec_helper"

module Franklin
  describe Collate do
    describe "#perform (combines multiple search results)" do
      let(:results) { Collate.new.perform([search_results_1, search_results_2]) }
      let(:search_results_1) {
        {
          item_1 => availability_1,
          item_2 => availability_2
        }
      }
      let(:search_results_2) {
        {
          item_2 => availability_3,
          item_3 => availability_4
        }
      }
      let(:item_1) { Item.random_fixture }
      let(:item_2) { Item.random_fixture }
      let(:item_3) { Item.random_fixture }
      let(:availability_1) { Availability.random_fixture }
      let(:availability_2) { Availability.random_fixture }
      let(:availability_3) { Availability.random_fixture }
      let(:availability_4) { Availability.random_fixture }

      it "includes all items and their availabilities" do
        expect(results).to eq({
          item_1 => [availability_1],
          item_2 => [availability_2, availability_3],
          item_3 => [availability_4]
        })
      end

      # it "dd" do
      #   puts [search_results_1, search_results_2].map { |result| result[item_1]? }
      # end
    end
  end
end
