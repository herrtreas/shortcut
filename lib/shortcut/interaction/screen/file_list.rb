module Shortcut
  module Interaction
    module Screen
      include Curses
      
      class FileList

        attr_accessor :screen
        attr_accessor :items
        
        def self.append(screen)
          screen.addstr("#{} ")
          screen.refresh
          self.new(screen)
        end      

        def initialize(screen)
          @screen = screen
        end
        
        def items=(new_list)
          @items = new_list
          Screen.preserved_position do
            @items.each_with_index do |item, index|
              @screen.setpos(index + 3, 1)
              @screen.addstr(item + "\n" )
            end
          end
          @screen.refresh
        end
        
      end
      
    end
  end
end