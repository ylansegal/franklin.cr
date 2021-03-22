require "../spec_helper"

module Franklin
  describe AvailabilityDescription do
    library = Library.fixture
    item = Item.random_fixture

    describe "#to_s" do
      context "when available_copies is greater 0" do
        it "describes it as available" do
          availability = Availability.new(library, 10, 2, 0)
          result = AvailabilityDescription.new(availability, item).to_s

          result.should eq("Available @ #{availability.library.name}")
        end
      end

      context "when available_copies is 0" do
        context "when wait_list_size is reported" do
          it "describes the people per copy" do
            availability = Availability.new(library, 4, 0, 13)

            result = AvailabilityDescription.new(availability, item).to_s

            result.should eq("3.2 people/copy @ #{availability.library.name}")
          end
        end

        context "when wait_list_size is 0" do
          it "describes the people per copy" do
            availability = Availability.new(library, 4, 0, 0)
            result = AvailabilityDescription.new(availability, item).to_s

            result.should eq("0.0 people/copy @ #{availability.library.name}")
          end
        end
      end
    end

    describe "#url" do
      it "returns a url for the given availability" do
        availability = Availability.new(library, 4, 0, 13)
        url = AvailabilityDescription.new(availability, item).url
        url.should eq("#{library.url}/media/#{item.id}")
      end

      context "when the library url has an ending /" do
        it "correctly formats the url" do
          base_url = "http://library.com"
          library = Library.new("Some library", "#{base_url}/")
          availability = Availability.new(library, 4, 0, 13)
          url = AvailabilityDescription.new(availability, item).url
          url.should eq("#{base_url}/media/#{item.id}")
        end
      end
    end
  end
end
