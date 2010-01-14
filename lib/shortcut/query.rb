module Shortcut
  class Query

    attr_accessor :items
    
    def initialize(index)
      @index = index
    end

    def update(keywords)
      @items = @index.find(keywords)
    end
  end
end
