require "../spec_helper"

module Franklin
  describe AvailabilityDescription do
    let(:library) { Library.fixture }
    let(:item) { Item.random_fixture }

    describe "#to_s" do
      let(:result) { AvailabilityDescription.new(availability, item).to_s }

      context "when available_copies is greater 0" do
        let(:availability) { Availability.new(library, 10, 2, 0) }

        it "describes it as available" do
          expect(result).to eq("Available @ #{availability.library.name}")
        end
      end

      context "when available_copies is 0" do
        context "when wait_list_size is reported" do
          let(:availability) { Availability.new(library, 4, 0, 13) }

          it "describes the people per copy" do
            expect(result).to eq("3.3 people/copy @ #{availability.library.name}")
          end
        end

        context "when wait_list_size is 0" do
          let(:availability) { Availability.new(library, 4, 0, 0) }

          it "describes the people per copy" do
            expect(result).to eq("0.0 people/copy @ #{availability.library.name}")
          end
        end
      end
    end

    describe "#url" do
      let(:url) { AvailabilityDescription.new(availability, item).url }
      let(:availability) { Availability.new(library, 4, 0, 13) }

      it "returns a url for the given availability" do
        expect(url).to eq("#{library.url}/media/#{item.id}")
      end

      context "when the library url has an ending /" do
        let(:base_url) { "http://library.com" }
        let(:library) { Library.new("Some library", "#{base_url}/") }

        it "correctly formats the url" do
          expect(url).to eq("#{base_url}/media/#{item.id}")
        end
      end
    end
  end
end
