require_relative '../blackjack'
require 'pry'

describe Blackjack do
  let(:blackjack) { Blackjack.new }
  # let(:blackjack_for_testing) do
  #   testing = Blackjack.new
  #
  #   testing.player.hand.clear_cards
  #   testing.dealer.hand.clear_cards
  # end

  describe '.new' do
    it 'creates two hands of two cards' do
      expect(blackjack.player.hand.cards.length).to eq(2)
    end

    it 'displays a message for player receiving a card' do
      expect(STDIN).to receive(:gets).and_return('s')
      expect{blackjack.play_game}.to output(/Player was dealt CARD/).to_stdout
    end

    it 'displays a message for dealer receiving a card' do
      expect(STDIN).to receive(:gets).and_return('s')
      expect{blackjack.play_game}.to output(/Dealer was dealt CARD/).to_stdout
    end
  end

  describe '#play_game' do
    let(:high_hand) { Hand.new([Card.new('d', 'Q'), Card.new('h', 'J')]) }
    let(:tie_high_hand) { Hand.new([Card.new('s', 'J'), Card.new('d', 'K')]) }
    let(:low_hand) { Hand.new([Card.new('d', '5'), Card.new('h', '7'), Card.new('d', 'A'), Card.new('c', '4')]) }
    let(:player_bust_hand) { Hand.new([Card.new('c', 'J'), Card.new('h', 'K'), Card.new('h', 'A')]) }
    let(:dealer_bust_hand) { Hand.new([Card.new('s', 'Q'), Card.new('d', 'K'), Card.new('h', '2')]) }

    context "player wins" do
      it "player hand value exceeds dealer hand value" do
        a = blackjack

        a.player.hand.clear_cards
        a.dealer.hand.clear_cards

        high_hand.cards.each do |card|
          a.player.hand.add_card(card)
        end

        low_hand.cards.each do |card|
          a.dealer.hand.add_card(card)
        end

        expect(a.player.hand.calculate_hand).to eq(20)
        expect(a.dealer.hand.calculate_hand).to eq(17)

        expect(STDIN).to receive(:gets).and_return('s')
        expect{blackjack.play_game}.to output(/Player wins!/).to_stdout
      end

      it "dealer busts" do
        a = blackjack

        a.player.hand.clear_cards
        a.dealer.hand.clear_cards

        high_hand.cards.each do |card|
          a.player.hand.add_card(card)
        end

        dealer_bust_hand.cards.each do |card|
          a.dealer.hand.add_card(card)
        end

        expect(a.player.hand.calculate_hand).to eq(20)
        expect(a.dealer.hand.calculate_hand).to eq(22)

        expect(STDIN).to receive(:gets).and_return('s')
        expect{blackjack.play_game}.to output(/Bust! You Win!/).to_stdout
      end
    end

    context "dealer wins" do
      it "player busts" do
        a = blackjack

        a.player.hand.clear_cards
        a.dealer.hand.clear_cards

        player_bust_hand.cards.each do |card|
          a.player.hand.add_card(card)
        end

        low_hand.cards.each do |card|
          a.dealer.hand.add_card(card)
        end

        expect(a.player.hand.calculate_hand).to eq(21)
        expect(a.dealer.hand.calculate_hand).to eq(17)

        expect(STDIN).to receive(:gets).and_return('h')
        expect{blackjack.play_game}.to output(/Bust! Game over.../).to_stdout
      end

      it "dealer hand value exceeds player hand value" do
        a = blackjack

        a.player.hand.clear_cards
        a.dealer.hand.clear_cards

        high_hand.cards.each do |card|
          a.dealer.hand.add_card(card)
        end

        low_hand.cards.each do |card|
          a.player.hand.add_card(card)
        end

        expect(a.player.hand.calculate_hand).to eq(17)
        expect(a.dealer.hand.calculate_hand).to eq(20)

        expect(STDIN).to receive(:gets).and_return('s')
        expect{blackjack.play_game}.to output(/Dealer wins!/).to_stdout
      end
    end

    it "tie game" do
      a = blackjack

      a.player.hand.clear_cards
      a.dealer.hand.clear_cards

      high_hand.cards.each do |card|
        a.dealer.hand.add_card(card)
      end

      tie_high_hand.cards.each do |card|
        a.player.hand.add_card(card)
      end

      expect(a.player.hand.calculate_hand).to eq(20)
      expect(a.dealer.hand.calculate_hand).to eq(20)

      expect(STDIN).to receive(:gets).and_return('s')
      expect{blackjack.play_game}.to output(/Tie game!/).to_stdout
    end
  end

end
