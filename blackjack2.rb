# blackjack2.rb

class Card
  RANKS = [*2..10, :Jack, :Queen, :King, :Ace]
  SUITS = [:Hearts, :Spades, :Diamonds, :Clubs]

  attr_reader   :rank, :suit, :value

  def initialize rank, suit
    if RANKS.include?(rank) && SUITS.include?(suit)
      @card = [rank, suit]
    else
      raise ArgumentError, "invalud :rank or :suit"
    end
  end

  def to_s
    rank, suit = @card
    "#{rank} of #{suit}"
  end

  def rank
    @card[0]
  end

  def suit
    @card[1]
  end

  def value
    case self.rank
    when :Ace
      11
    when :King
      10
    when :Queen
      10
    when :Jack
      10
    else
      self.rank
    end
  end
end

class Deck
  attr_reader :number_of_decks, :percent_reserved
  attr_reader :in_reserve, :count

  def initialize number_of_decks = 1, percent_reserved = 20.0
    @number_of_decks = number_of_decks
    @percent_reserved = percent_reserved
    @cards = []
    for i in 1..@number_of_decks
      Card::SUITS.product( Card::RANKS ) { | suit, rank | @cards << Card.new(rank, suit) }
    end
    @number_of_reserve_cards = (@cards.count.to_f * @percent_reserved / 100).to_i
  end

  def print
    puts "#{@cards.count}-card deck"
    @cards.each do | card |
      puts "  #{card}"
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def cut
    @cards.rotate! @cards.count / 2
  end

  def draw
    @cards.shift
  end

  def count
    @cards.count
  end

  def in_reserve?
    @cards.count < @number_of_reserve_cards && true || false
  end
end

class Blackjack
  attr_reader   :total, :wins, :pushes, :losses

  def initialize number_of_decks = 6, percent_reserved = 25.0
    @number_of_decks = number_of_decks
    @percent_reserved = percent_reserved
    @total = 0
    @wins = 0
    @pushes = 0
    @losses = 0
  end

  def play

    @cards = Deck.new @number_of_decks, @percent_reserved

    @cards.shuffle
    @cards.cut

    while !@cards.in_reserve? do

      player = []
      dealer = []
      for i in 1..2
        player += [@cards.draw]
        dealer += [@cards.draw]
      end

      while player_strategy(player, dealer[1]) == :hit
        player += [@cards.draw]
      end

      while dealer_strategy(dealer) == :hit
        dealer += [@cards.draw]
      end

      player_result = results_of_hand(player)
      dealer_result = results_of_hand(dealer)
      if  (dealer_result == :blackjack && player_result != :blackjack) || player_result == :bust
        @losses += 1
      elsif player_result == :blackjack || dealer_result == :bust
        @wins += 1
      elsif dealer_result > player_result
        @losses += 1
      elsif player_result > dealer_result
        @wins += 1
      else
        @pushes += 1
      end
      @total += 1
    end
  end

  def hand_contains? hand, rank
    hand.each do | card |
      if rank == card.rank
        return true
      end
    end
    false
  end

  def value_of_hand hand
    ace_count = 0
    value = 0

    hand.each do | card |
      value += card.value
      if card.rank == 'Ace'
        ace_count += 1
      end
    end

    while value > 21 && ace_count > 0
      value -= 10
      ace_count -= 1
    end
    value
  end

  def results_of_hand hand
    value = value_of_hand hand
    case value
    when 21
      hand.count == 2 && :blackjack || 21
    when 12..20
      value
    when 0..11
      raise "error, illegal hand"
    else
      :bust
    end
  end

  def player_strategy hand, dealer_up_card
    strategy = :stand
    hand_value = value_of_hand hand

    if hand.count == 2 && hand_contains?(hand, 'Ace')
      if hand_value >= 19
        strategy =  :stand
      elsif hand_value == 18 && [2, 7, 8].include?(dealer_up_card.value)
        strategy =  :stand
      else
        strategy = :hit
      end
    else
      if hand_value <= 11 || (hand_value == 12 && dealer_up_card.value.between?(2, 3))
        strategy =  :hit
      elsif hand_value >= 17 || dealer_up_card.value.between?(2, 6)
        strategy =  :stand
      elsif hand_value < (dealer_up_card.value + 10)
        strategy =  :hit
      end
    end
    strategy
  end

  def dealer_strategy hand
    value = value_of_hand hand
    value >= 17 && :stand || :hit
  end

end
