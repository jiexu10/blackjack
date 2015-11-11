
class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def face_card?
    %w(J Q K).include?(value)
  end

  def ace_card?
    "A" == value
  end

end
