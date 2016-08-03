class Monster
  attr_reader :toughness, :damage, :perception, :gold, :exp
  
  def initialize(attr={})
    @toughness  = attr[:toughness]
    @damage     = attr[:damage]
    @perception = attr[:perception]
    @gold       = attr[:gold]
    @exp        = attr[:exp]
    
    @dead       = false
  end
  
  def dead?
    @dead
  end
  
  def kill
    @dead = true
  end
end