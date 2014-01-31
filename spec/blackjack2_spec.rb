require_relative '../blackjack2.rb'

describe "Card" do
  before do
    @card1 = Card.new(2, :Hearts)
    @card2 = Card.new(:Ace, :Spades)
  end

  it "should create a valid card" do
    expect(@card1).to be_a_kind_of Card
    expect(@card2).to be_a_kind_of Card
  end

  it "should raise ArgumentError for invalid arguments" do
    expect{ Card.new(1, :Hearts) }.to raise_error ArgumentError
    expect{ Card.new(:Ace, :fred) }.to raise_error ArgumentError
  end

  it "should return the correct value" do
    expect(@card1.value).to eq 2
    expect(@card2.value).to eq 11
  end
end

describe "Deck" do
  before do
    @deck = Deck.new(2)
  end

  it "should create a valid deck" do
    expect(@deck).to be_a_kind_of Deck
  end

  it "should shuffle a deck" do
    deck = @deck
    expect(@deck.shuffle).to_not eq  deck
  end

  it "should cut a deck" do
    deck = @deck
    expect(@deck.shuffle).to_not eq  deck
  end

  it "should draw a card" do
    card = @deck.draw
    expect(card).to be_a_kind_of Card
  end

  it "should report when deck is in reserve" do
    count = @deck.count
    while !@deck.in_reserve? do
      card = @deck.draw
      expect(card).to be_a_kind_of Card
    end
    expect(@deck.count).to be <  count/3
  end
end

describe "Blackjack" do

  it "should run successfully" do
    total_games = 0
    total_wins = 0
    total_non_losses = 0

    for i in 1..10000 do
      game = Blackjack.new
      game.play
      total_games += game.total
      total_wins += game.wins
      total_non_losses += (game.wins + game.pushes)
    end

    percent = total_wins / total_games.to_f * 100
    puts "In #{total_games} games, Player wins #{"%0.2f" % percent}%"
    percent = total_non_losses / total_games.to_f * 100
    puts "    Player doesn't loose #{"%0.2f" %percent}%"
  end

end
