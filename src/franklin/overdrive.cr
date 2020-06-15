require "json"

module Franklin
  module Overdrive
    struct Data
      include JSON::Serializable

      property data : Hash(String, Overdrive::Entry)
    end

    struct Entry
      include JSON::Serializable

      property title : String
      property firstCreatorName : String
      property type : Type
      property ownedCopies : Int32 = 1
      property availableCopies : Int32 = 1
      property holdsCount : Int32 = 0

      def to_item(id : String) : Item
        Franklin::Item.new(id, title, firstCreatorName, type.name)
      end

      def to_availability(library : Library) : Availability
        Franklin::Availability.new(library, ownedCopies, availableCopies, holdsCount)
      end
    end

    struct Type
      include JSON::Serializable

      property name : String
    end
  end
end
