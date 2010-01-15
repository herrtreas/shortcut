require 'rbcurse/keylabelprinter'

module Shortcut
  module Interaction
    module Frontend
      module Controls
        class Footer
          include RubyCurses
          
          attr_accessor :field
          
          def initialize(form)
            @form = form
            draw
          end

          def draw
            key_labels = [
              ['C-q', 'Exit'], ['', '']
              # ['C-q', 'Exit'], ['', '']
            ]
            
            @field = KeyLabelPrinter.new(@form, key_labels) do
              row Ncurses.LINES - 2
            end
          end
          
        end
      end
    end
  end
end
