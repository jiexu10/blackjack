require 'pry'

class Hand
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def add_card(card)
    @cards << card
  end

  def clear_cards
    @cards = []
  end

  def calculate_hand
    hand_total = 0
    ace_count = 0
    cards.each do |card|
      if card.face_card?
        hand_total += 10
      elsif card.ace_card?
        hand_total += 1
        ace_count += 1
      else
        hand_total += card.value.to_i
      end
    end
    hand_total = optimize_aces(hand_total, ace_count)
  end

  private

  def optimize_aces(hand_total, ace_count)
    new_score = hand_total
    ace_count.times do
      if new_score + 10 <= 21
        new_score = new_score + 10
      end
    end
    new_score
  end

end
