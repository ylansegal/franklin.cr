module Franklin
  class TypeFilter
    property type : (String | Nil)

    def initialize(@type)
    end

    def perform(results : Hash(Item, Array(Availability))) : Hash(Item, Array(Availability))
      filter(results, type  )
    end

    private def filter(results, type : Nil)
      results
    end

    private def filter(results, type : String)
      results.select { |item, _| item.format.compare(type, case_insensitive: false) == 0 }
    end
  end
end
