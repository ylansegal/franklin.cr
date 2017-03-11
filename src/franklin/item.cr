module Franklin
  struct Item
    property id : String
    property title : String
    property author : String
    property format : String

    def initialize(@id, @title, @author, @format)
    end
  end
end
