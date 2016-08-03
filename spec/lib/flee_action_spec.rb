require 'spec_helper'
require_relative '../../lib/flee_action'

describe FleeAction do
  let(:hero) { double("hero", stealth: 3) }
  let(:monster) { double("monster", perception: 4) }
  let(:dicepool) { double("dicepool") }
  let(:action) { FleeAction.new hero, dicepool }
  
  describe "activate" do
    
    it "makes stealth check against target perception" do
      expect(dicepool).to receive(:skill_check).with(hero.stealth, monster.perception)
      action.activate(monster)
    end
  end
  
  describe "effect" do
  end
   
  it "responds to activate message" do
    expect(action).to respond_to(:activate)
  end
  
  it "has an owner" do
    expect(action.owner).to eq(hero)
  end
end