module Franklin
  struct Availability
    property library : Library
    property total_copies : Int32
    property available_copies : Int32
    property wait_list_size : Int32

    def initialize(@library, @total_copies, @available_copies, @wait_list_size)
    end

    def persons_per_copy
      return 0 if wait_list_size == 0 && total_copies == 0

      (wait_list_size.to_f / total_copies.to_f).round(1)
    end
  end
end
