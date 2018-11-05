require "../spec_helper"

module Franklin
  describe TypeFilter do
    type = "holobook"
    item_type = type
    item_1 = Item.random_fixture(item_type)
    item_2 = Item.random_fixture
    availability_1 = Availability.random_fixture
    availability_2 = Availability.random_fixture
    results = {
      item_1 => [availability_1],
      item_2 => [availability_2],
    }
    subject = TypeFilter.new(type)
    filtered_results = subject.perform(results)

    it "filters results for a given type" do
      filtered_results.should eq({item_1 => [availability_1]})
    end

    context "when type is in different case" do
      it "filters results" do
        type = "HoLoBOOK"
        subject = TypeFilter.new(type)

        subject.perform(results).should eq({item_1 => [availability_1]})
      end
    end

    context "when the type is nil" do
      it "returns unmodified results" do
        type = nil
        item_type =  "VCR_Tape"
        subject = TypeFilter.new(type)

        subject.perform(results).should eq(results)
      end
    end
  end
end
