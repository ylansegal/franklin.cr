require "../spec_helper"

module Franklin
  describe ConsoleReport do
    subject { ConsoleReport.new(search_terms, collated_results) }
    let(:search_terms) { "crime and punishment" }
    let(:collated_results) { { item => [availability] } }
    let(:result) { subject.to_s(io).to_s }
    let(:io) { IO::Memory.new }
    let(:item) { Item.random_fixture }
    let(:availability) { Availability.random_fixture }
    let(:availability_description) { AvailabilityDescription.new(availability).to_s }

    describe ".print_to_out" do
      it "includes search_term" do
        expect(result).to match(/#{search_terms}/)
      end

      it "includes item information" do
        expect(result).to match(/^#{item.title}/m)
        expect(result).to match(/^By #{item.author}/m)
        expect(result).to match(/^Format: #{item.format}/m)
      end

      it "includes availability information" do
        expect(result).to match(/^Availability:/m)
        expect(result).to match(/^  #{availability_description}/m)
      end
    end
  end
end
