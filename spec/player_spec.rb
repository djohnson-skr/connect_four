require_relative '../lib/player'
require 'colorize'

describe Player do
  context "Create a new player" do
    player = Player.new('Player1', '●'.red)

    it "creates a new player with a name" do
      expect(player.name).to eq('Player1')
    end
  
    it "creates a new player with a disc" do
      expect(player.disc).to eq('●'.red)
    end
  end
end