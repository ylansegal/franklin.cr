require "../spec_helper"

module Franklin
  describe Availability do
    subject { Availability.new(library, total_copies, available_copies, wait_list_size) }
    let(:library) { Library.fixture }
    let(:total_copies) { 10 }
    let(:available_copies) { 2 }
    let(:wait_list_size) { 0 }

    it "has a library" do
      expect(subject.library).to eq(library)
    end

    it "has total_copies" do
      expect(subject.total_copies).to eq(total_copies)
    end

    it "has available_copies" do
      expect(subject.available_copies).to eq(available_copies)
    end

    it "has wait_list_size" do
      expect(subject.wait_list_size).to eq(wait_list_size)
    end
  end
end
