require "../spec_helper"

module Franklin
  class TestSearcher
    def initialize(@library : Library, @results : Hash(Item, Availability))
    end

    def perform(search_terms)
      @results
    end
  end


  describe ConcurrentSearch do
    subject { ConcurrentSearch(TestSearcher).new(libraries) }
    let(:libraries) { [library_1, library_2] }
    let(:library_1) { Library.random_fixture }
    let(:library_2) { Library.random_fixture }

    describe "#perform" do
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
      let(:search_terms) { "Harry Potter" }
      let(:searchers) {
        [
          TestSearcher.new(library_1, search_results_1),
          TestSearcher.new(library_2, search_results_2)
        ]
      }
      let(:results) { subject.perform(search_terms) }

      before {
        subject.searchers = searchers
      }

      it "returns collated results from multiple libraries" do
        expect(results).to eq([search_results_1, search_results_2])
      end

      context "when no search term is provided" do
        let(:search_terms) { "" }

        it "raises an ArgumentError" do
          expect { results }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
