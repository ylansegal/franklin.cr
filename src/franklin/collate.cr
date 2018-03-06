module Franklin
  class Collate
    def perform(search_results) : Hash(Item, Array(Availability))
      items = Set.new(search_results.flat_map(&.keys))
      items.each_with_object({} of Item => Array(Availability)) { |item, collation|
        collation[item] = sorted_results_for_item(search_results, item)
      }
    end

    private def sorted_results_for_item(search_results, item)
      search_results.map { |result|
        result[item]?
      }.compact.sort_by { |a|
        [a.available_copies, 1 / a.persons_per_copy]
      }.reverse
    end
  end
end
