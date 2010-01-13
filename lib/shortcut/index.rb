module Shortcut
  class Index
    
    def self.load
      if (File.exist?("/Users/andreas/.shortcut.index"))
        puts "Loading index.."
        lines = []
        File.open("/Users/andreas/.shortcut.index", "r") do |f|
          lines = f.readlines
        end
      else
        puts "Updating index.."
        lines = %x(find /Users/andreas/Development -type d).split("\n")
        File.open("/Users/andreas/.shortcut.index", "w") do |f|
          lines.each { |line| f << line + "\n"}
        end
      end

      self.new(lines)
    end
    
    def initialize(lines)
      @lines = lines
    end
    
    def find(search_term)
      @lines.select do |line|
        line.include?(search_term)
      end[0...10]
    end
    
  end
end