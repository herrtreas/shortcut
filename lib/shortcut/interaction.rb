module Shortcut
  module Interaction
    
    autoload :Frontend, 'shortcut/interaction/frontend'
    autoload :Screen,   'shortcut/interaction/screen'
      
    KEY_ESC         = 27
    KEY_RETURN      = 10    
    KEY_RETURN_ALT  = 13
    KEY_TAB         = 9
    
    ACTION_KEYS = [KEY_TAB, KEY_ESC, KEY_RETURN, KEY_RETURN_ALT]
    
    class << self
      
      attr_accessor :commander
      attr_accessor :selected_item
      
      def start(query, commander)
        @query = query
        @commander = commander
        Frontend.create
      end
      
      def handle_action_for(key)
        case key
        when KEY_RETURN, KEY_RETURN_ALT
          Frontend.close
          new_location = @selected_item || "~"
          puts "Jump to: #{new_location}"
          @commander.switch_location(new_location)
          exit(0)
        when KEY_ESC
          exit(0)
        end
      end
      
      def query(keywords)
        @query.update(keywords)
        @selected_item = @query.items.first
        Frontend.update_item_list(@query.items)
      end
      
    end
    
  end
end