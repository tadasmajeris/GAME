require 'spec_helper'
require_relative '../../lib/action'

class TestAction < Action
  def action_attributes
    @attribute = :strength
    @difficulty = :toughness
  end
end

describe Action do
  let(:hero) { double("hero", strength: 3, gain_exp: nil, gain_gold: nil, damage: nil) }
  let(:monster) { double("monster", toughness: 2, damage: 4, kill: nil) }
  let(:dicepool) { double("dicepool") }
  let(:action) { TestAction.new hero, dicepool }
  
  it_behaves_like "action"
  
  it "requires action attributes to be implemented" do
    expect { Action.new hero, dicepool }.to raise_error(StandardError)
  end
  
  describe "activate" do
    it "sends success message if skill check is successful" do
      allow(dicepool).to receive(:skill_check).and_return(true)
      expect(action).to receive(:success)
      action.activate(monster)
    end
    it "sends failure message if skill check is successful" do
      allow(dicepool).to receive(:skill_check).and_return(false)
      expect(action).to receive(:failure)
      action.activate(monster)
    end
  end
end