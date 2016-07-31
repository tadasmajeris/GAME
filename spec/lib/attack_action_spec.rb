require 'spec_helper'
require_relative '../../lib/attack_action'

describe AttackAction do
  let(:hero) { double("hero", strength: 3, gain_exp: nil, gain_gold: nil, damage: nil) }
  let(:monster) { double("monster", toughness: 2, damage: 4, kill: nil) }
  let(:dicepool) { double("dicepool") }
  let(:action) { AttackAction.new hero, dicepool }
  
  describe "activate" do
    
    it "makes strength check against target toughness" do
      expect(dicepool).to receive(:skill_check).with(hero.strength, monster.toughness)
      action.activate(monster)
    end
  end
  
  describe "effect" do
    context "success" do
      before :each do
        allow(dicepool).to receive(:skill_check).and_return(true)
      end
      
      it "kills monster" do
        expect(monster).to receive(:kill)
        action.activate(monster)
      end
      it "rewards owner with exp" do
        expect(hero).to receive(:gain_exp)
        action.activate(monster)
      end
      it "rewards owner with gold" do
        expect(hero).to receive(:gain_gold)
        action.activate(monster)
      end
    end
    context "failure" do
      it "damages owner" do
        allow(dicepool).to receive(:skill_check).and_return(false)
        expect(hero).to receive(:damage).with(monster.damage)
        action.activate(monster)
      end
    end
  end
  
  it "responds to activate message" do
    expect(action).to respond_to(:activate)
  end
  
  it "has an owner" do
    expect(action.owner).to eq(hero)
  end
end