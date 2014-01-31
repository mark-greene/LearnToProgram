# blackjack2.rb

class Card
  RANKS = [*2..10, :Jack, :Queen, :King, :Ace]
  SUITS = [:Hearts, :Spades, :Diamonds, :Clubs]

  attr_reader   :rank, :suit, :value

  def initialize rank, suit = :Clubs
    if RANKS.include?(rank) && SUITS.include?(suit)
      @rank = rank
      @suit = suit
      @value =  self.rank_value
    else
      raise ArgumentError, "invalud :rank or :suit"
    end
  end

  def to_s
    "#{@rank} of #{@suit}"
  end

  def rank_value
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
    for i in 1..@number_of_decks do
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
    @cards.count < @number_of_reserve_cards
  end
end

class Hand
  attr_reader   :count, :value

  def initialize hand = nil
    if hand.nil?
      @hand =  []
      @value = nil
    else
      @hand = [hand]
      @value = self.hand_value
    end
  end

  def hand_value
    ace_count = 0
    value = 0

    @hand.each do | card |
      value += card.value
      if card.rank == :Ace
        ace_count += 1
      end
    end

    while value > 21 && ace_count > 0
      value -= 10
      ace_count -= 1
    end
    value
  end

  def result
    case self.value
    when 21
      self.count == 2 && :blackjack || 21
    when 12..20
      value
    when 0..11
      raise "error, illegal hand"
    else
      :bust
    end
  end

  def add_card card
    @hand += [card]
    @value = self.hand_value
  end

  def count
    @hand.count
  end

  def card position
    @hand[position]
  end

  def contains? rank
    @hand.each do | card |
      if rank == card.rank
        return true
      end
    end
    false
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

      player = Hand.new @cards.draw
      dealer = Hand.new @cards.draw
      player.add_card(@cards.draw)
      dealer.add_card(@cards.draw)

      while player_strategy(player, dealer.card(1)) == :hit do
        player.add_card(@cards.draw)
      end

      while dealer_strategy(dealer) == :hit do
        dealer.add_card(@cards.draw)
      end

      if  (dealer.result == :blackjack && player.result != :blackjack) || player.result == :bust
        @losses += 1
      elsif player.result == :blackjack || dealer.result == :bust
        @wins += 1
      elsif dealer.result > player.result
        @losses += 1
      elsif player.result > dealer.result
        @wins += 1
      else
        @pushes += 1
      end
      @total += 1
    end
  end

  def player_strategy hand, dealer_up_card
    strategy = :stand

    if hand.count == 2 && hand.contains?(:Ace)
      if hand.value >= 19
        strategy =  :stand
      elsif hand.value == 18 && [2, 7, 8].include?(dealer_up_card.value)
        strategy =  :stand
      else
        strategy = :hit
      end
    else
      if hand.value <= 11 || (hand.value == 12 && dealer_up_card.value.between?(2, 3))
        strategy =  :hit
      elsif hand.value >= 17 || dealer_up_card.value.between?(2, 6)
        strategy =  :stand
      elsif hand.value < (dealer_up_card.value + 10)
        strategy =  :hit
      end
    end
    strategy
  end

  def dealer_strategy hand
    hand.value >= 17 && :stand || :hit
  end

  def hand_builder *ranks
    hand = Hand.new
    ranks.each { |rank| hand.add_card( Card.new(rank)) }
    hand
  end

end
