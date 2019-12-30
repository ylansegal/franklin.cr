require "../spec_helper"

module Franklin
  describe Collate do
    describe "#perform (combines multiple search results)" do
      item_1 = Item.random_fixture
      item_2 = Item.random_fixture
      item_3 = Item.random_fixture
      availability_1 = Availability.random_fixture
      availability_2 = Availability.random_fixture(1)
      availability_3 = Availability.random_fixture(0)
      availability_4 = Availability.random_fixture
      search_results_1 = {
        item_1 => availability_1,
        item_2 => availability_2,
      }
      search_results_2 = {
        item_2 => availability_3,
        item_3 => availability_4,
      }

      it "includes all items and their availabilities" do
        results = Collate.new.perform([search_results_1, search_results_2])

        results.should eq({
          item_1 => [availability_1],
          item_2 => [availability_2, availability_3],
          item_3 => [availability_4],
        })
      end
    end

    context "ordering of availabilities" do
      item_1 = Item.random_fixture
      availability_1 = Availability.new(Library.random_fixture, 10, 3, 0)
      availability_2 = Availability.new(Library.random_fixture, 20, 0, 4)
      availability_3 = Availability.new(Library.random_fixture, 10, 0, 3)
      search_results_1 = {item_1 => availability_3}
      search_results_2 = {item_1 => availability_1}
      search_results_3 = {item_1 => availability_2}

      it "shows available copies first, then by copies per person" do
        results = Collate.new.perform([search_results_1, search_results_2, search_results_3])

        results.should eq({
          item_1 => [availability_1, availability_2, availability_3],
        })
      end
    end
  end
end
