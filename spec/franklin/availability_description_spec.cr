require "../spec_helper"

module Franklin
  describe AvailabilityDescription do
    library = Library.fixture
    item = Item.random_fixture

    describe "#to_s" do
      context "when available_copies is greater 0" do
        availability = Availability.new(library, 10, 2, 0)

        it "describes it as available" do
          result = AvailabilityDescription.new(availability, item).to_s

          result.should eq("Available @ #{availability.library.name}")
        end
      end

      context "when available_copies is 0" do
        context "when wait_list_size is reported" do
          availability = Availability.new(library, 4, 0, 13)

          it "describes the people per copy" do
            result = AvailabilityDescription.new(availability, item).to_s

            result.should eq("3.3 people/copy @ #{availability.library.name}")
          end
        end

        context "when wait_list_size is 0" do
          availability = Availability.new(library, 4, 0, 0)

          it "describes the people per copy" do
            result = AvailabilityDescription.new(availability, item).to_s

            result.should eq("0.0 people/copy @ #{availability.library.name}")
          end
        end
      end
    end

    describe "#url" do
      availability = Availability.new(library, 4, 0, 13)

      it "returns a url for the given availability" do
        url = AvailabilityDescription.new(availability, item).url
        url.should eq("#{library.url}/media/#{item.id}")
      end

      context "when the library url has an ending /" do
        base_url = "http://library.com"
        library = Library.new("Some library", "#{base_url}/")

        it "correctly formats the url" do
          availability = Availability.new(library, 4, 0, 13)
          url = AvailabilityDescription.new(availability, item).url
          url.should eq("#{base_url}/media/#{item.id}")
        end
      end
    end
  end
end
