module Franklin
  class AvailabilityDescription
    def initialize(@availability : Availability, @item : Item)
    end

    forward_missing_to @availability

    def to_s
      "#{copies_information} @ #{library.name}"
    end

    def url
      "#{library.url}/media/#{@item.id}"
    end

    private def copies_information
      available? ? "Available" : "#{copies_per_person} people/copy"
    end

    private def available?
      available_copies > 0
    end

    private def copies_per_person
      (wait_list_size.to_f / total_copies.to_f).round(1)
    end

    private def wait_list?
      wait_list_size > 0
    end
  end
end
