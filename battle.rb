class Hero
  attr_reader   :health, :strength, :stealth
  
  def initialize health, strength, stealth
    @health = health
    @strength = strength
    @stealth = stealth
    @@fled = false
  end
  
  def flee(monster)
    dice = Dice.new stealth, monster.perception
    @@fled = dice.roll_success?
  end
  
  def attack(monster)
    dice = Dice.new strength, monster.toughness
    if dice.roll_success?
      monster.toughness = 0
      return true
    else
      @health -= monster.damage
      @health = 0 if health.negative?
      return false
    end
  end
  
  def dead?
    health <= 0
  end
  
  def fled?
    @@fled
  end
end

class Monster
  attr_accessor :toughness
  attr_reader   :damage, :perception
  
  def initialize toughness, damage, perception
    @toughness = toughness
    @damage = damage
    @perception = perception
  end
  
  def dead?
    @toughness == 0
  end
end

class Dice
  attr_accessor :dice_rolls, :n, :comparison
  
  def initialize n, comparison
    @dice_rolls = []
    @n = n
    @comparison = comparison
  end
  
  def roll_success?
    n.times { dice_rolls << rand(1..6) }
    print_rolls dice_rolls
    successes = dice_rolls.count { |die| die >= 5 }
    return successes >= comparison
  end
  
  def print_rolls dice_rolls
    print "Rolls: "
    
    dice_rolls.each { |die|
      print case die 
              when 1 then '⠂'  when 2 then '⠈⠄' when 3 then '⠑⠄' 
              when 4 then '⠨⠅' when 5 then '⠕⠅' when 6 then '⠸⠇' end
      print ' '
    }
    puts "\n"
  end
end

class GamePrinter
  $LINE_WIDTH = 60
  
  def self.print_special txt=nil
    puts '=' * $LINE_WIDTH
    puts txt if txt
  end

  # prints object's name(class), it's variables and their values
  def self.print_attributes object
    print (object.class.to_s.upcase + ': ').rjust($LINE_WIDTH/4)
    object.instance_variables.each { |attribute|
      attribute = attribute[1..-1]
      print (attribute + ":").ljust($LINE_WIDTH/4-4)
      print "#{object.send(attribute)}  ".rjust(4)
    }
    puts
  end
end

# --------------------
def battle_result hero
  return "YOU LOST! :(" if hero.dead? 
  return "YOU RAN AWAY..." if hero.fled?
  "YOU WON!"
end

# PROGRAM
hero = Hero.new 10, 5, 3
monster = Monster.new rand(2..3), 4, 2

GamePrinter.print_special "BATTLE STARTS!"
GamePrinter.print_attributes hero
GamePrinter.print_attributes monster
GamePrinter.print_special

until hero.fled? || monster.dead? || hero.dead?
  puts "\nAttacking the monster"
  
  if hero.attack(monster)
    puts "> Hit!!!!"
  else
    puts "> You missed. Monster dealt #{monster.damage} damage."
    puts "> Your current health is #{hero.health}"
    if !hero.dead?
      puts "Trying to flee..."
      hero.flee(monster)
      puts "> Unlucky... Monster spotted you!" if !hero.fled?
    end
  end
end

GamePrinter.print_special battle_result(hero)+"\n\n"