require "../spec_helper"

module Franklin
  describe ConsoleReport do
    availability =  Availability.random_fixture
    item =  Item.random_fixture
    collated_results =  {item => [availability]}
    search_terms =  "crime and punishment"
    io =  IO::Memory.new
    subject = ConsoleReport.new(search_terms, collated_results)
    result =  subject.to_s(io).to_s

    availability_description =  AvailabilityDescription.new(availability, item)

    describe ".to_s" do
      it "includes search_term" do
        result.should match(/#{search_terms}/)
      end

      it "includes item information" do
        result.should match(/^#{item.title}/m)
        result.should match(/^By #{item.author}/m)
        result.should match(/^Format: #{item.format}/m)
      end

      it "includes availability information" do
        result.should match(/^Availability:/m)
        result.should match(/^  #{availability_description.to_s}/m)
        result.should match(/^    #{availability_description.url}/m)
      end
    end
  end
end
