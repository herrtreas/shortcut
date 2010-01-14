module Shortcut
  module Interaction
    module Frontend
      module Controls
        class ItemList
          include RubyCurses
          
          attr_accessor :items
          
          
          def initialize(form)
            @form = form
            @items = []
            draw
          end
          
          def items=(new_items)
            @items = new_items[0..(Ncurses.LINES - 5)]
            @field.list_data_model.remove_all
            @items.each do |item|
              @field.list_data_model.append(item)
            end
            
            # @field.repaint
          end
          
          def draw
            items = @items            
            @field = Listbox.new(@form) do
              name   "items"
              row  1
              col  2
              width Ncurses.COLS - 4
              height Ncurses.LINES - 3
              list items
            end
          end
            
        end
      end
    end
  end
end
