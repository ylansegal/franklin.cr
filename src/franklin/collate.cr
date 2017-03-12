module Franklin
  class Collate
    def perform(search_results) : Hash(Item, Array(Availability))
      items = Set.new(search_results.flat_map(&.keys))
      items.each_with_object({} of Item => Array(Availability)) { |item, collation|
        search_results.map { |result| result[item]? }.compact
        collation[item] = search_results.map { |result| result[item]? }.compact
      }
    end
  end
end
