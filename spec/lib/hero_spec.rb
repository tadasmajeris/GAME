require 'spec_helper'
require_relative '../../lib/hero'

describe Hero do
  let(:dicepool) { double("dicepool")  }
  
  describe "default attributes" do
    let(:hero) { Hero.new }
    
    it "has default strength equal to 3" do
      expect(hero.strength).to eq(3)
    end
    it "has default health equal to 10" do
      expect(hero.health).to eq(10)
    end
  end
  
  it "can be initialized with custom strength" do
    hero = Hero.new strength: 4
    expect(hero.strength).to eq(4)
  end
  it "can be initialized with custom health" do
    hero = Hero.new health: 8
    expect(hero.health).to eq(8)
  end
  
  describe "attack" do
    it "succeeds" do
      dicepool.stub(:skill_check).and_return(true)
      hero = Hero.new dicepool: dicepool
      monster = double("monster", toughness: 2)
      expect(hero.attack(monster)).to be true
    end
    it "fails" do
      dicepool.stub(:skill_check).and_return(false)
      hero = Hero.new dicepool: dicepool
      monster = double("monster", toughness: 2)
      expect(hero.attack(monster)).to be false
    end
  end
end