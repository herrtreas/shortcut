module Shortcut
  class Query

    attr_accessor :term
    attr_accessor :items
    
    def initialize(index)
      @term = ""
      @index = index
    end

    def update(new_character)
      @term << new_character
      @items = @index.find(@term)
    end
  end
end
