class Hero
  attr_reader   :strength
  attr_accessor :health
  
  def initialize health, strength
    @health = health
    @strength = strength
  end
  
  def attack(monster)
    attack = rand(strength)
    attack >= monster.toughness
  end
  
  def dead?
    health <= 0
  end
end

class Monster
  attr_reader   :damage
  attr_accessor :toughness
  
  def initialize toughness, damage
    @toughness = toughness
    @damage = damage
  end
  
  def dead?
    toughness <= 0
  end
end


def print_special txt
  puts '=' * 35
  puts txt
end

def battle_result(hero)
  return hero.dead? ? "YOU LOST! :(" : "YOU WON! :)"
end

# PROGRAM
hero = Hero.new 10, 4
monster = Monster.new rand(2..3), 4

puts
print_special "Battle started!\nMonster's toughness: #{monster.toughness}\n\n"

until monster.dead? || hero.dead?
  if hero.attack(monster)
    monster.toughness = 0
    puts "You hit! You kill the monster!"
  else
    puts "You missed. Monster dealt #{monster.damage} damage."
    hero.health -= monster.damage
    puts "Your current health is #{hero.health}"
  end
end

print_special battle_result(hero)+"\n\n"