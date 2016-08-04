require 'io/console'
require_relative 'lib/attack_action'
require_relative 'lib/flee_action'
require_relative 'lib/hero'
require_relative 'lib/monster'
require_relative 'lib/dicepool'

hero = Hero.new strength: 5, stealth: 5, health: 15, 
                actions: { attack: AttackAction.new(hero, Dicepool.new), 
                           flee: FleeAction.new(hero, Dicepool.new) }

def print_action_options
  puts
  puts "(a)ttack, (f)lee"
  puts "----------------------------------------------"
end

kills = 0
flees = 0

puts
puts "How many monsters would you like to fight today?"
print "Enter number: "
bravery_measure = gets.chomp.strip.to_i

bravery_measure.times do |i|
  toughness   = rand(1..3)
  perception  = rand(1..3)
  damage      = toughness + rand(1..2)
  mult        = rand(1..4)
  monster = Monster.new toughness: toughness, perception: perception, damage: damage, 
                        exp: toughness * mult, gold: damage * mult
                        
  puts 
  puts "=============================================="
  puts "You are fighting MONSTER #{i + 1} with"
  puts "\ttoughness: #{monster.toughness}"
  puts "\tperception: #{monster.perception}"
  puts "What do you do? (a) for attack, (f) for flee"
  puts "----------------------------------------------"
  
  battle_is_over = false
  
  until battle_is_over do
    
    command_key = STDIN.getch
    if command_key == 'a'
      hero.activate_action(:attack, monster)
      
      if monster.dead?
        puts "YOU WON"
        puts "You gained #{monster.exp} experience"
        puts "You gained #{monster.gold} gold"
        puts "----------------------------------------------"
        battle_is_over = true
        kills += 1 
      else
        puts "YOU MISSED"
        puts "Monster dealt #{monster.damage} damage to you"
        puts "Your health is #{hero.health}"
        
        if hero.dead? 
          battle_is_over = true
        else
          print_action_options
        end
      end
    elsif command_key == 'f'
      hero.activate_action(:flee, monster)
      
      if hero.fled?
        puts "YOU RAN AWAY"
        battle_is_over = true
        flees += 1
      else
        puts "YOU HAVE BEEN SPOTTED"
        puts "Monster dealt #{monster.damage} damage to you"
        puts "Your health is #{hero.health}"
        
        if hero.dead? 
          battle_is_over = true
        else
          print_action_options
        end
      end
    else
      puts "(a) for attack, (f) for flee"
    end
  end
  
  break if hero.dead?
  hero.reset_fled
end

puts "=============================================="
if hero.dead?
  puts "YOU DIDN'T MAKE IT :("
else
  puts "VICTORY!!! :)"
  puts "You earned #{hero.exp} experience and #{hero.gold} gold."
  puts "You killed #{kills} monsters and ran away from #{flees}."
end
puts