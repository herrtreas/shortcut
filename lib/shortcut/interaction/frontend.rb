require 'ncurses'
require 'rbcurse'
require 'logger'

module Shortcut
  module Interaction
    module Frontend
    
      autoload :Controls, 'shortcut/interaction/frontend/controls'
    
      class << self
        include RubyCurses

        def create

          begin
            catch(:close) do
              VER::start_ncurses
              $log = Logger.new("/tmp/shortcut_view.log")
              $log.level = Logger::DEBUG
              @window = VER::Window.root_window
              @form = Form.new(@window)
              
              # Controls::OptionTab.new(@form)
              @search_box = Controls::SearchBox.new(@form)
              @item_list = Controls::ItemList.new(@form)
              
              @form.repaint
              @window.wrefresh
            
              Ncurses::Panel.update_panels
              
              loop do
                char = @window.getchar
                
                if Shortcut::Interaction::ACTION_KEYS.include?(char.to_i)
                  Interaction.handle_action_for char.to_i
                else
                  if @form.active_index == @item_list.field.id
                    @form.active_index = @search_box.field.id
                  end

                  Interaction.query(@search_box.value)
                end
                
                @form.handle_key(char)
                @search_box.update_cursor_position
                @window.wrefresh
              end
            end
          rescue => exception
            puts exception
            puts(exception.backtrace.join("\n"))
            $log.debug(exception)
            $log.debug(exception.backtrace.join("\n"))
          ensure
            close
          end

        end
        
        def close
          return if @_closed
          @_closed = true
          @window.destroy if !@window.nil?
          VER::stop_ncurses
        end
        
        def update_item_list(new_items)
          @item_list.items = new_items
        end
        
        def selected_item
          @item_list.selected
        end
      end
      
    end
  end
end
