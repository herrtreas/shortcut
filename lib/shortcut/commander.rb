require 'appscript'

module Shortcut
  class Commander
    include Appscript
    
    def switch_location(new_location)
      term = app('Terminal')
      active_window = nil
      for i in 0..term.windows.count
        active_window = term.windows[i].get if term.windows[i].frontmost.get == true
      end
      
      active_tab = nil
      for t in 0..active_window.tabs.count
        active_tab = active_window.tabs[t] if active_window.tabs[t].selected.get == true
      end
      
      term.do_script("cd #{new_location}", :in => active_tab)
    end
    
  end
end