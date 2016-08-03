require 'spec_helper'
require_relative '../../lib/monster'

describe Monster do
  let(:monster) { Monster.new toughness: 2, damage: 4, perception: 1, gold: 5, exp: 20 }
  
  it "has toughness"  do expect(monster.toughness).to   eq(2) end
  it "has damage"     do expect(monster.damage).to      eq(4) end
  it "has perception" do expect(monster.perception).to  eq(1) end
  it "has gold"       do expect(monster.gold).to        eq(5) end
  it "has exp"        do expect(monster.exp).to         eq(20) end
	
  it "is alive on initialization" do
    expect(monster.dead?).to be false
  end
  
  it "can be killed" do
    monster.kill
    expect(monster.dead?).to be true
  end
end