require 'curses'

module Shortcut
  module Interaction
    
    autoload :Screen, 'shortcut/interaction/screen'
      
    KEY_ESC     = 27    
    KEY_RETURN  = 10
    KEY_TAB     = 9
    
    ACTION_KEYS = [KEY_TAB, KEY_ESC, KEY_RETURN]
    
    class << self
      
      attr_accessor :commander
      attr_accessor :selected_item
      
      def start(query, commander)
        @query = query
        @commander = commander
        Screen.build
      end
      
      def handle_action_for(key)
        case key
        when KEY_RETURN
          Screen.close
          new_location = @selected_item || "~"
          puts "Jump to: #{new_location}"
          @commander.switch_location(new_location)
          exit(0)
        when KEY_ESC
          exit(0)
        end
      end
      
      def query(char)
        @query.update(char)
        @selected_item = @query.items.first
        Screen.file_list.items = @query.items
      end
      
    end
    
  end
end