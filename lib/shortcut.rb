module Shortcut
  
  autoload :Commander,    'shortcut/commander'
  autoload :Index,        'shortcut/index'
  autoload :Interaction,  'shortcut/interaction'
  autoload :Query,        'shortcut/query'
  
  class << self
    def boot!
      index = Index.load
      commander = Commander.new
      active_query = Query.new(index)
      Interaction.start(active_query, commander)
    end
  end
  
end