require "../spec_helper"

module Franklin
  class ConsoleReportLet
    property subject : ConsoleReport
    property result : String
    property availability_description : AvailabilityDescription
    property search_terms : String
    property item : Item

    def initialize(@search_terms = "crime and punishment")
      @item = Item.random_fixture
      availability = Availability.random_fixture
      collated_results = {item => [availability]}
      io = IO::Memory.new

      @subject = ConsoleReport.new(search_terms, collated_results)
      @result = subject.to_s(io).to_s
      @availability_description = AvailabilityDescription.new(availability, item)
    end
  end

  describe ConsoleReport do
    describe ".to_s" do
      it "includes search_term" do
        let = ConsoleReportLet.new
        let.result.should match(/#{let.search_terms}/)
      end

      it "includes item information" do
        let = ConsoleReportLet.new
        result = let.result
        item = let.item

        result.should match(/^#{item.title}/m)
        result.should match(/^By #{item.author}/m)
        result.should match(/^Format: #{item.format}/m)
      end

      it "includes availability information" do
        let = ConsoleReportLet.new
        result = let.result
        availability_description = let.availability_description

        result.should match(/^Availability:/m)
        result.should match(/^  #{availability_description.to_s}/m)
        result.should match(/^    #{availability_description.url}/m)
      end
    end
  end
end
