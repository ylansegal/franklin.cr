require "../spec_helper"

module Franklin
  describe Availability do
    library = Library.fixture
    total_copies = 11
    available_copies = 0
    wait_list_size = 3
    subject = Availability.new(library, total_copies, available_copies, wait_list_size)

    it "has a library" do
      subject.library.should eq(library)
    end

    it "has total_copies" do
      subject.total_copies.should eq(total_copies)
    end

    it "has available_copies" do
      subject.available_copies.should eq(available_copies)
    end

    it "has wait_list_size" do
      subject.wait_list_size.should eq(wait_list_size)
    end

    it "reports persons_per_copy" do
      subject.persons_per_copy.should eq(0.3)
    end
  end
end
