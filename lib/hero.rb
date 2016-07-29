class Hero
    attr_reader :strength, :health
    
    def initialize attr={}
        @strength = attr[:strength] || 3
        @health   = attr[:health]   || 10
        @dicepool = attr[:dicepool]
    end
    
    def attack(monster)
        @dicepool.skill_check(strength, monster.toughness)
    end
end