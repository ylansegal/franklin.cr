require "uri"

module Franklin
  class AvailabilityDescription
    def initialize(@availability : Availability, @item : Item)
    end

    forward_missing_to @availability

    def to_s
      "#{copies_information} @ #{library.name}"
    end

    def url
      URI.parse(library.url).tap { |uri|
        uri.path = "/media/#{@item.id}"
      }.to_s
    end

    private def copies_information
      available? ? "Available" : "#{persons_per_copy} people/copy"
    end

    private def available?
      available_copies > 0
    end

    private def wait_list?
      wait_list_size > 0
    end
  end
end
