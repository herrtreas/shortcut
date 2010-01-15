module Shortcut
  module Interaction
    
    autoload :Frontend, 'shortcut/interaction/frontend'
    autoload :Screen,   'shortcut/interaction/screen'
      
    KEY_RETURN      = 10    
    KEY_RETURN_ALT  = 13
    KEY_TAB         = 9
    KEY_DOWN        = 258
    KEY_UP          = 259
    
    ACTION_KEYS = [KEY_TAB, KEY_RETURN, KEY_RETURN_ALT, KEY_DOWN, KEY_UP]
    
    class << self
      
      attr_accessor :commander
      
      def start(query, commander)
        @query = query
        @commander = commander
        Frontend.create
      end
      
      def handle_action_for(key)
        case key
        when KEY_RETURN, KEY_RETURN_ALT
          Frontend.close
          @commander.switch_location(Frontend.selected_item)
          exit(0)
        end
      end
      
      def query(keywords)
        @query.update(keywords)
        Frontend.update_item_list(@query.items)
      end
      
    end
    
  end
end