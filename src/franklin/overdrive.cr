require "json"

module Franklin
  module Overdrive
    struct Data
      JSON.mapping(
        data: Hash(String, Overdrive::Entry)
      )
    end

    struct Entry
      JSON.mapping(
        title: String,
        firstCreatorName: String,
        type: Type,
        ownedCopies: { type: Int32, default: 0 },
        availableCopies: { type: Int32, default: 0 },
        holdsCount: { type: Int32, default: 0 }
      )

      def to_item(id)
        Franklin::Item.new(id, title, firstCreatorName, type.name)
      end

      def to_availability(library)
        Franklin::Availability.new(library, ownedCopies, availableCopies, holdsCount)
      end
    end

    struct Type
      JSON.mapping(
        name: String
      )
    end
  end
end
