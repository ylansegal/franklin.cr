require "../spec_helper"

module Franklin
  module Test
    class Search
      include SearchInterface

      def initialize(@library : Library, @results : Hash(Item, Availability))
      end

      def perform(search_terms) : Hash(Item, Availability)
        @results
      end
    end
  end

  describe ConcurrentSearch do
    library_1 = Library.random_fixture
    library_2 = Library.random_fixture
    libraries = [library_1, library_2]
    subject = ConcurrentSearch.new(libraries)


    describe "#perform" do
      item_1 = Item.random_fixture
      item_2 = Item.random_fixture
      item_3 = Item.random_fixture
      availability_1 = Availability.random_fixture
      availability_2 = Availability.random_fixture
      availability_3 = Availability.random_fixture
      availability_4 = Availability.random_fixture
      search_results_1 = {
          item_1 => availability_1,
          item_2 => availability_2,
        }
      search_results_2 = {
          item_2 => availability_3,
          item_3 => availability_4,
        }

      search_terms = "Harry Potter"
      searchers = [
          Test::Search.new(library_1, search_results_1).as(SearchInterface),
          Test::Search.new(library_2, search_results_2).as(SearchInterface),
        ]

      subject.searchers = searchers
      results = subject.perform(search_terms)

      it "returns collated results from multiple libraries" do
        results.should eq([search_results_1, search_results_2])
      end

      context "when no search term is provided" do

        it "raises an ArgumentError" do
          expect_raises(ArgumentError) do
            subject.perform("")
          end
        end
      end
    end
  end
end
