require 'spec_helper'
require_relative '../../lib/flee_action'

describe FleeAction do
  let(:hero) { double("hero", stealth: 3, flee: nil, damage: nil) }
  let(:monster) { double("monster", perception: 4, damage: 4) }
  let(:dicepool) { double("dicepool") }
  let(:action) { FleeAction.new hero, dicepool }
  
  it_behaves_like "action"
  it_behaves_like "subaction"
  
  it "has stealth attribute" do
    expect(action.attribute).to eq(:stealth)
  end
  
  it "has perception for difficulty" do
    expect(action.difficulty).to eq(:perception)
  end
  
  describe "effect" do
    context "success" do
      it "sends a flee message to the owner" do
        allow(dicepool).to receive(:skill_check).and_return(true)
        expect(hero).to receive(:flee)
        action.activate(monster)
      end
    end
    context "failure" do
      it "deals damage to the owner" do
        allow(dicepool).to receive(:skill_check).and_return(false)
        expect(hero).to receive(:damage).with(monster.damage)
        action.activate(monster)
      end
    end
  end
end