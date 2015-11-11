require_relative '../lib/player'
require_relative '../lib/hand'


describe Player do
  let(:player) { Player.new("player", Hand.new)}
  describe '#new' do
    it 'takes a name and hand as arguments' do
      expect(player.name).to eq('player')
      expect(player).to be_a(Player)
      expect(player.hand).to be_a(Hand)
    end

  end
end
