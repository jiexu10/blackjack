require_relative '../lib/hand'

describe Hand do
  let(:num_hand) { Hand.new([Card.new('d', '5'), Card.new('h', '7')]) }
  let(:num_face_hand) { Hand.new([Card.new('d', 'K'), Card.new('h', '8')]) }
  let(:face_hand) { Hand.new([Card.new('d', 'Q'), Card.new('h', 'J')]) }
  let(:ace_hand) { Hand.new([Card.new('d', '5'), Card.new('h', 'A')]) }
  let(:mult_ace_hand) { Hand.new([Card.new('d', 'K'), Card.new('h', 'A'), Card.new('s', 'A')]) }
  let(:mult_ace_hand_fail) { Hand.new([Card.new('d', '5'), Card.new('h', 'A'), Card.new('s', 'A')]) }


  #
  # (:num_face_hand) { Hand.new(["8♦", "J♥"]) }
  # let(:face_hand) { Hand.new(["K♦", "J♥"]) }
  # let(:ace_hand) { Hand.new(["3♦", "A♥"]) }
  # let(:mult_ace_hand) { Hand.new(["J♦", "A♥", "A♣"]) }
  # let(:mult_ace_hand_fail) { Hand.new(["5♦", "A♥", "A♣"]) }

  describe "#add_card" do
    it "adds a card to the existing hand" do
      three_card_hand = num_hand.add_card(Card.new('h', 'K'))
      expect(three_card_hand.count).to eq(3)
      expect(three_card_hand[0].suit).to eq('d')
      expect(three_card_hand[0].value).to eq('5')
      expect(three_card_hand[1].suit).to eq('h')
      expect(three_card_hand[1].value).to eq('7')
      expect(three_card_hand[2].suit).to eq('h')
      expect(three_card_hand[2].value).to eq('K')
    end
  end


  describe "#calculate_hand" do
    # Sample tests (change these once you understand)
    it "can calculate a hand with all number cards" do
      # use `expect` to test assertions
      expect(num_hand.calculate_hand).to eq(12)
    end

    it "can calculate a hand with number cards and face cards" do
      expect(num_face_hand.calculate_hand).to eq(18)
    end

    it "can calculate a hand with all face cards" do
      expect(face_hand.calculate_hand).to eq(20)
    end

    it "can calculate a hand with an ace with the best score" do
      expect(ace_hand.calculate_hand).to eq(16)
    end

    it "can calculate a hand with multiple aces with the best score" do
      expect(mult_ace_hand.calculate_hand).to eq(12)
    end

    it "fails calculating to the wrong value for a hand with number cards" do
      expect(num_hand.calculate_hand).to_not eq(19)
    end

    it "fails to give the unoptimized value for a hand with aces" do
      expect(mult_ace_hand_fail).to_not eq(7)
    end
    # add the remaining tests here
  end
end
