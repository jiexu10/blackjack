require_relative '../lib/card'

describe Card do
  let(:card) { Card.new('c', 5) }
  let(:face_card) { Card.new('h', 'K') }
  let(:ace_card) { Card.new('s', 'A') }

  describe '#initialize' do
    it 'takes a suit and a value as arguments' do
      expect(card).to be_a(Card)
      expect(card.suit).to eq('c')
      expect(card.value).to eq(5)
    end

  end

  describe '#face_card?' do
    it 'correctly determines whether the card is a face card' do
      expect(card.face_card?).to eq(false)
      expect(face_card.face_card?).to eq(true)
      expect(ace_card.face_card?).to eq(false)
    end
  end

  describe '#ace_card?' do
    it 'correctly determines whether the card is a face card' do
      expect(card.ace_card?).to eq(false)
      expect(face_card.ace_card?).to eq(false)
      expect(ace_card.ace_card?).to eq(true)
    end
  end


end
