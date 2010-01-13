require 'ostruct'

module Shortcut
  module Interaction
    module Screen

      autoload :InputField, 'shortcut/interaction/screen/input_field'
      autoload :FileList,   'shortcut/interaction/screen/file_list'
            
      class << self
        attr_accessor :action_handle
        attr_accessor :input_field
        attr_accessor :file_list
        attr_accessor :position
        attr_accessor :screen
        
        include Curses
      
        def build
          @position = OpenStruct.new(:x => 0, :y => 0)
          @screen = init_screen
          begin
            crmode
            noecho
            stdscr.keypad(true)
          
            @input_field = InputField.append(@screen)
            @file_list = FileList.append(@screen)
          
            loop do
              char = getch
              if Shortcut::Interaction::ACTION_KEYS.include?(char.to_i)
                Interaction.handle_action_for char.to_i
              else
                input_field.append_character(char.chr)
                Interaction.query(char.chr)
              end
            end
          ensure
            close_screen
          end
        end
        
        def close
          close_screen
        end
        
        def print(txt)
          @screen.addstr(txt)
        end
        
        def position=(new_position)
          @position = new_position
          update_position
        end
        
        def update_position
          @screen.setpos(@position.y, @position.x)
          @screen.refresh
        end
        
        def preserved_position(&block)
          old_position = @position
          yield
          position = old_position
        end
      end
      
    end
  end
end