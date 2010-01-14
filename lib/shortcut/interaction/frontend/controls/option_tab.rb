require 'rbcurse/rtabbedpane'

module Shortcut
  module Interaction
    module Frontend
      module Controls
        class OptionTab
          
          def initialize(form)
            @form = form
            draw
          end
          
          def draw
            @tp = RubyCurses::TabbedPane.new nil  do
              height 12
              width  50
              row 5
              col 10
              button_type :ok
            end
          end
          
        end
      end
    end
  end
end
