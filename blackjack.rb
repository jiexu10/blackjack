
require_relative 'lib/card.rb'
require_relative 'lib/deck.rb'
require_relative 'lib/hand.rb'
require_relative 'lib/player.rb'
require 'pry'

class Blackjack
  attr_reader :player, :dealer
  def initialize
    @deck = Deck.new
    @player = Player.new('Player', Hand.new)
    @dealer = Player.new('Dealer', Hand.new)
    start_game
  end

  def play_game
    @turn = player
    player_turn
    dealer_turn unless @turn == "busted"
    find_winner unless @turn == "busted"
  end


  private

  def start_game
    2.times do
      deal_card(player, 1)
      deal_card(dealer, 1)
    end
  end

  def player_turn
    display_hand(player.hand)
    while @turn == player
      player_choice
      if player.hand.calculate_hand > 21
        puts "Bust! Game over..."
        @turn = "busted"
      end
    end
  end

  def dealer_turn
    display_hand(dealer.hand)
    while @turn == dealer
      dealer_choice
      if dealer.hand.calculate_hand > 21
        puts "Bust! You Win!"
        @turn = "busted"
      else
        @turn = "end of game"
      end
    end
  end

  def player_choice
    puts "Hit or stand (H/S):"
    choice = STDIN.gets.chomp
    if choice == 'h'
      hit(player)
    elsif choice == 's'
      stand
    else
      puts "Invalid input, please try again!"
    end
  end

  def dealer_choice
    while dealer.hand.calculate_hand < 17
      hit(dealer)
    end
  end

  def stand
    display_hand(player.hand)
    puts "\nYou stand. Dealer's turn..."
    @turn = dealer
  end

  def hit(which_player)
    if @turn == which_player
      deal_card(which_player, 1)
      display_hand(which_player.hand)
    end
  end

  def deal_card(which_player, num_of_cards)
    dealt_cards = @deck.deal(num_of_cards)
    dealt_cards.each do |card|
      which_player.hand.add_card(card)
      puts "#{which_player.name} was dealt CARD"
    end
  end

  def display_hand(hand)
    print "\n"
    print "#{@turn.name} hand: "
    hand.cards.each do |card|
      print "#{card.value}#{card.suit} "
    end
    print "\n#{@turn.name} score: #{@turn.hand.calculate_hand} \n"
  end

  def find_winner
    print "\n"
    winner = player.hand.calculate_hand <=> dealer.hand.calculate_hand
    if winner == 1
      puts "Player wins!"
    elsif winner == 0
      puts "Tie game!"
    elsif winner == -1
      puts "Dealer wins!"
    end
  end

end

#
# my_game = Blackjack.new
# my_game.play_game
