module Shortcut
  module Interaction
    module Frontend
      module Controls
        class SearchBox
          include RubyCurses
          
          attr_accessor :field
          
          def initialize(form)
            @form = form
            draw
          end

          def draw
            @field = Field.new @form do
              name "search"
              row  0
              col  3
              display_length  75
              maxlen 200
              set_label Label.new @form, {'text' => ">>", 'color'=>'white'}
            end
          end

          def value
            @field.getvalue
          end
          
          def update_cursor_position
            @form.setpos(0, @field.getvalue.length + 3)
          end
          
        end
      end
    end
  end
end
