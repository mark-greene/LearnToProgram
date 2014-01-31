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
NUMBER_OF_RUNS = 10000

  before do
    @game = Blackjack.new
  end

  context "dealer strategy" do
    it "should :hit when hand is less than 17" do
      hand = @game.hand_builder 5, 5, 5
      expect(@game.dealer_strategy hand).to eq :hit
    end

    it "should :stand when hand is  17 or better" do
      hand = @game.hand_builder 5, 5, 5, 5
      expect(@game.dealer_strategy hand).to eq :stand
    end
  end

  context "player strategy" do
    it "should :hit 11 or less (can't bust)" do
      hand = @game.hand_builder 5, 6
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(6, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :hit
    end

    it "should :hit on 12 when dealer has 2 or 3" do
      hand = @game.hand_builder 5, 5, 2
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :hit
    end

    it "should :stand when dealer has a :bust card (3..6)" do
      hand = @game.hand_builder 5, 5, 2
      expect(@game.player_strategy hand, Card.new(4, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(6, :Clubs)).to eq :stand
      hand = @game.hand_builder 5, 5, 3
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :stand
    end

    it "should :hit on 16 or less when dealer has 7 or better" do
      hand = @game.hand_builder 5, 5, 2
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :hit
      hand = @game.hand_builder 5, 5, 6
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :hit
    end

    it "should :stand on 17 or better" do
      hand = @game.hand_builder 5, 5, 7
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(6, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :stand
      hand = @game.hand_builder 5, 5, 10
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(6, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :stand
    end
  end

  context "player strategy with an :Ace" do
    it "should :stand on 19 or better" do
      hand = @game.hand_builder 8, :Ace
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(6, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(9, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :stand
    end

    it "should :stand on 18 when dealer has 2, 7 or 8" do
      hand = @game.hand_builder 7, :Ace
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :stand
      expect(@game.player_strategy hand, Card.new(8, :Clubs)).to eq :stand
    end

    it "should :hit on 18 when dealer dealer does not have 2, 7 or 8" do
      hand = @game.hand_builder 7, :Ace
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(6, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(9, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :hit
    end

    it "should :hit on 17 or less" do
      hand = @game.hand_builder 2, :Ace
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(8, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(10, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Jack, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :hit
      hand = @game.hand_builder 6, :Ace
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(3, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(2, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(7, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(8, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(10, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Jack, :Clubs)).to eq :hit
      expect(@game.player_strategy hand, Card.new(:Ace, :Clubs)).to eq :hit
    end
  end

  context "game simulation" do
    it "should run successfully" do

      for i in 1..NUMBER_OF_RUNS do
        @game.play
      end

      percent = @game.wins / @game.total.to_f * 100
      puts "    In #{@game.total} games, Player wins #{"%0.2f" % percent}%"
      percent = (@game.wins + @game.pushes) / @game.total.to_f * 100
      puts "       Player doesn't loose #{"%0.2f" %percent}%"
    end
  end

end
