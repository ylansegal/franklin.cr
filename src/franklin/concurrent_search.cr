module Franklin
  class ConcurrentSearch(T)
    property searchers : Array(Search) | Array(T)

    def initialize(@libraries : Array(Library))
      @searchers = @libraries.map { |library| Search.new(library) }
    end

    def perform(search_terms : String) : Array(Hash(Item, Availability))
      raise ArgumentError.new("Please provide at least one search term") if search_terms.blank?
      channel =  Channel(Hash(Item, Availability)).new
      searchers.each do |searcher|
        spawn do
          channel.send(searcher.perform(search_terms))
        end
      end
      searchers.map { channel.receive }
    end
  end
end
