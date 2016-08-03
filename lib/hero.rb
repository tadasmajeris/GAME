class Hero
    attr_reader :strength, :health, :stealth, :actions, :gold, :exp
    
    def initialize attr={}
        @strength = attr[:strength] || 3
        @health   = attr[:health]   || 10
        @stealth  = attr[:stealth]  || 1
        @actions  = attr[:actions]  || {}
        
        own_actions
        
        @gold     = 0
        @exp      = 0
        @fled     = false
    end
    
    def own_actions
      @actions.each { |key, action| action.assign_owner(self) } 
    end
    
    def activate_action(action_name, target)
      actions[action_name].activate(target)
    end
    
    def damage(hit)
      @health -= hit
    end
    
    def fled?
      @fled
    end
    
    def flee
      @fled = true
    end
    
    def gain_gold(amount)
      @gold += amount
    end
    
    def gain_exp(amount)
      @exp += amount
    end
end