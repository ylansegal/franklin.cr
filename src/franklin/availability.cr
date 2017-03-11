module Franklin
  struct Availability
    property library : Library
    property total_copies : Int32
    property available_copies : Int32
    property wait_list_size : Int32

    def initialize(@library, @total_copies, @available_copies, @wait_list_size)
    end
  end
end
