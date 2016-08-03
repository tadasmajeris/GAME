class Dicepool
    
  def skill_check(attribute, difficulty)
    dice = []
    attribute.times { dice << roll_die }
    dice.count {|die| die >= 5 } >= difficulty
  end
  
  def roll_die
    rand(1..6)
  end
  
end