class Hero
    attr_reader :strength, :health, :actions
    
    def initialize attr={}
        @strength = attr[:strength] || 3
        @health   = attr[:health]   || 10
        @actions  = attr[:actions]  || {}
    end
    
    def activate_action(action_name, target)
      actions[action_name].activate(target)
    end
end