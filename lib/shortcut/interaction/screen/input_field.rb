module Shortcut
  module Interaction
    module Screen
      include Curses
      
      class InputField

        attr_accessor :screen
        
        def self.append(screen)
          screen.setpos(0,0)
          screen.addstr(">> ")
          screen.refresh
          self.new(screen)
        end      

        def initialize(screen)
          @_pos_x = 3
          @screen = screen
        end
        
        def append_character(new_char)
          @_pos_x += 1
          Screen.position.x = @_pos_x
          Screen.update_position
          @screen.addstr(new_char)
          @screen.refresh
        end
        
      end
      
    end
  end
end