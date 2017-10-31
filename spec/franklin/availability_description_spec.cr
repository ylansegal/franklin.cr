require "../spec_helper"

module Franklin
  describe AvailabilityDescription do
    describe "#to_s" do
      let(:result) { AvailabilityDescription.new(availability).to_s }
      let(:library) { Library.fixture }

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
  end
end
