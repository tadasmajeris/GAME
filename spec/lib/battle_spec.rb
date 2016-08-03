require 'spec_helper'
require_relative "../../lib/hero"
require_relative "../../lib/monster"
require_relative "../../lib/attack_action"
require_relative "../../lib/flee_action"
require_relative "../../lib/dicepool"

describe "Battle" do
  let(:dicepool) { Dicepool.new }
  let(:hero) { Hero.new strength: 5,
                        health:   10,
                        actions: {
                          attack: AttackAction.new(self, dicepool),
                          flee:   FleeAction.new(self, dicepool)
                        }
              }
  let(:monster) { Monster.new toughness: 2,
                              perception: 1,
                              damage: 4,
                              exp: 10,
                              gold: 20
                }
    
  describe "Hero attacks monster" do
   
    context "successful attack" do
      before :each do
        allow(dicepool).to receive(:roll_die).and_return(5)
        allow(Dicepool).to receive(:new).and_return(dicepool)
        hero.activate_action :attack, monster
      end
      it "kills monster" do 
        expect(monster).to be_dead
      end
      it "gets monster's gold" do
        expect(hero.gold).to eq(20)
      end
      it "gets experience" do
        expect(hero.exp).to eq(10)
      end
    end
    
    context "failed attack" do
      before :each do
        allow(dicepool).to receive(:roll_die).and_return(2)
        allow(Dicepool).to receive(:new).and_return(dicepool)
        hero.activate_action :attack, monster
      end
      it "takes damage" do
        expect(hero.health).to eq(6)
      end
    end
  end
  
  describe "Hero flees from monster" do
    context "successful attempt" do
      before :each do
        allow(dicepool).to receive(:roll_die).and_return(5)
        allow(Dicepool).to receive(:new).and_return(dicepool)
        hero.activate_action :flee, monster
      end
      it "fled" do
        expect(hero.fled?).to be true
      end
    end
    context "failed attempt" do
      before :each do
        allow(dicepool).to receive(:roll_die).and_return(2)
        allow(Dicepool).to receive(:new).and_return(dicepool)
        hero.activate_action :flee, monster
      end
      it "takes damage" do
        expect(hero.fled?).to be false
        expect(hero.health).to eq(6)
      end
    end
  end
  
end