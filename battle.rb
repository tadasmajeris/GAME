class Hero
  attr_reader   :strength, :health
  
  def initialize health, strength
    @health = health
    @strength = strength
  end
  
  def print_rolls dice_rolls
    print "\nRolls: "
    
    dice_rolls.each { |die|
      print case die 
              when 1 then '⠂' when 2 then '⠈⠄' when 3 then '⠑⠄' 
              when 4 then '⠨⠅' when 5 then '⠕⠅' when 6 then '⠸⠇' end
      print ' '
    }
    puts "\n"
  end
  
  def attack(monster)
    dice_rolls = []
    strength.times { dice_rolls << rand(1..6) }
    print_rolls dice_rolls
    
    successes = dice_rolls.count { |die| die >= 5 }
    if successes >= monster.toughness
      return true
    else
      @health -= monster.damage
      return false
    end
  end
  
  def dead?
    health <= 0
  end
end

class Monster
  attr_reader   :damage, :toughness
  
  def initialize toughness, damage
    @toughness = toughness
    @damage = damage
  end
end


def print_special txt
  puts '=' * 40
  puts txt
end

def battle_result(hero)
  return hero.dead? ? "YOU LOST! :(" : "YOU WON! :)"
end

# PROGRAM
hero = Hero.new 10, 5
monster = Monster.new rand(2..3), 4

puts
print_special "BATTLE STARTED!"
puts "Monster's toughness: #{monster.toughness}"
puts "Hero's strength:     #{hero.strength}"

until hero.attack(monster) || hero.dead?
  puts "You missed. Monster dealt #{monster.damage} damage."
  puts "Your current health is #{hero.health}"
end

print_special battle_result(hero)+"\n\n"