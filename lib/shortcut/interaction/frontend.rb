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
                  Interaction.query(@search_box.value)
                end

                @form.handle_key(char)
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
          @window.destroy if !@window.nil?
          VER::stop_ncurses
        end
        
        def update_item_list(new_items)
          @item_list.items = new_items
        end
        
      end
      
    end
  end
end
