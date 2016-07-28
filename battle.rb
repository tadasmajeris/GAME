class Hero
  attr_reader   :health, :strength, :stealth
  
  def initialize health, strength, stealth
    @health = health
    @strength = strength
    @stealth = stealth
    @fled = false
  end
  
  def print_rolls dice_rolls
    print "Rolls: "
    
    dice_rolls.each { |die|
      print case die 
              when 1 then '⠂' when 2 then '⠈⠄' when 3 then '⠑⠄' 
              when 4 then '⠨⠅' when 5 then '⠕⠅' when 6 then '⠸⠇' end
      print ' '
    }
    puts "\n"
  end
  
  def flee(monster)
    dice_rolls = []
    stealth.times { dice_rolls << rand(1..6) }
    print_rolls dice_rolls
    successes = dice_rolls.count { |die| die >= 5 }
    if successes >= monster.perception
      @fled = true
    else
      @fled = false
      puts "> Unlucky... Monster spotted you!"
    end
  end
  
  def attack(monster)
    puts "\nAttacking the monster"
    dice_rolls = []
    strength.times { dice_rolls << rand(1..6) }
    print_rolls dice_rolls
    
    successes = dice_rolls.count { |die| die >= 5 }
    if successes >= monster.toughness
      puts "> Hit!!!!"
      return true
    else
      @health -= monster.damage
      return false
    end
  end
  
  def dead?
    health <= 0
  end
  
  def fled?
    @fled
  end
end

class Monster
  attr_reader   :toughness, :damage, :perception
  
  def initialize toughness, damage, perception
    @toughness = toughness
    @damage = damage
    @perception = perception
  end
end

$LINE_WIDTH = 60

def print_special txt=nil
  puts '=' * $LINE_WIDTH
  puts txt if txt
end

def battle_result(hero)
  return "YOU LOST! :(" if hero.dead? 
  return "YOU RAN AWAY..." if hero.fled?
  "YOU WON!"
end

# PROGRAM
hero = Hero.new 10, 5, 3
monster = Monster.new rand(2..3), 4, 2

print_special "BATTLE STARTS!"
print "MONSTER: Toughness: #{monster.toughness}".ljust($LINE_WIDTH/3+5)
print "Damage: #{monster.damage}".ljust($LINE_WIDTH/3)
print "Perception: #{monster.perception}".ljust($LINE_WIDTH/3)
puts
print "HERO:    Strength: #{hero.strength}".ljust($LINE_WIDTH/3+5)
print "Health: #{hero.health}".ljust($LINE_WIDTH/3)
print "Stealth: #{hero.stealth}".ljust($LINE_WIDTH/3)
puts
print_special

until hero.attack(monster) || hero.dead? || hero.fled?
  puts "> You missed. Monster dealt #{monster.damage} damage."
  puts "Your current health is #{hero.health}"
  
  puts "Trying to flee..."
  hero.flee(monster)
end

print_special battle_result(hero)+"\n\n"