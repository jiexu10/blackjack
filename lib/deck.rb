require_relative 'card.rb'

class Deck
  SUITS = ['d', 'c', 's', 'h']
  VALUES = [2,3,4,5,6,7,8,9,10,'J','Q','K','A']

  attr_accessor :cards

  def initialize
    @cards = build_deck
  end

  def build_deck
    cards = []
    SUITS.each do |suit|
      VALUES.each do |value|
        string_value = value.to_s
        cards << Card.new(suit, string_value)
      end
    end
    cards.shuffle!
  end

  def deal(num)
    cards.pop(num)
  end
end

# require 'pry'
# binding.pry
