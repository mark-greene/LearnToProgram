# cards.rb
SUITS = ['Hearts', 'Spades', 'Diamonds', 'Clubs']
RANKS = [*2..10, 'Jack', 'Queen', 'King', 'Ace']
CARDS = []
SUITS.product( RANKS ) { | suit, rank | CARDS << [rank, suit] }

  def print_cards cards
    puts "#{cards.count}-card deck"
    cards.each do | rank, suit |
      puts "  #{rank} of #{suit}"
    end
  end

  def shuffle_cards cards
    cards.shuffle!
  end

  def cut_cards cards
    cards.rotate! cards.count / 2
  end

  def draw_card cards
    cards.shift
  end

  def print_card card
    rank, suit = card
    puts "#{rank} of #{suit}"
  end

  def card_value card
    rank, suit = card
    case rank
    when 'Ace'
      11
    when 'King'
      10
    when 'Queen'
      10
    when 'Jack'
      10
    else
      rank.to_i
    end
  end

  def load_shoe number_of_decks
    shoe = []
    for i in 1..number_of_decks
      shoe += CARDS
    end
    shoe
  end

  def hand_value hand
    ace_count = 0
    value = 0

    hand.each do | card |
      rank, suit = card
      value += card_value card
      if rank == 'Ace'
        ace_count += 1
      end
    end

    while value > 21 && ace_count > 0
      value -= 10
      ace_count -= 1
    end

    value
  end

  def player_strategy hand, dealer_up_card
    strategy = :stand
    hand_value = hand_value hand
    card_value = card_value dealer_up_card
    if hand_value <=11
      strategy =  :hit
    elsif card_value >= 2 && card_value <= 6
      strategy =  :stand
    elsif hand_value < card_value
      strategy =  :hit
    end
    strategy
  end

  def dealer_strategy hand
    v = hand_value hand
    v >= 17 && :stand || :hit
  end

  def hand_result hand
    v = hand_value hand
    case v
    when 21
      hand.count == 2 && :natural || 21
    when 4..20
      v
    when 0..3
      raise "error, illegal resulting hand value"
    else
      :bust
    end
  end


# Main
cards = shuffle_cards load_shoe 6
cards = cut_cards cards

wins = 0
losses = 0
pushes = 0

while cards.count > 24

  player = []
  dealer = []
  for i in 1..2
    card = draw_card cards
    player += [card]
    card = draw_card cards
    dealer += [card]
  end

  while player_strategy(player, dealer[1]) == :hit do
    card = draw_card cards
    player += [card]
  end

  while dealer_strategy(dealer) == :hit do
    card = draw_card cards
    dealer += [card]
  end

  player_result = hand_result(player)
  dealer_result = hand_result(dealer)
  if player_result == :natural || dealer_result == :bust
    puts "Player wins with #{player_result}"
    wins += 1
  elsif  dealer_result == :natural || player_result == :bust
    puts "Dealer wins with #{dealer_result}"
    losses += 1
  elsif player_result > dealer_result
    puts "Player wins with #{player_result}"
    wins += 1
  elsif dealer_result > player_result
    puts "Dealer wins with #{dealer_result}"
    losses += 1
  else
    puts "Push - #{dealer_result}"
    pushes += 1
  end
# print_cards player
# print_cards dealer

end

puts "Wins - #{wins}, Losses - #{losses}, Push - #{pushes}"
