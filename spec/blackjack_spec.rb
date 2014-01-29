require_relative '../cards.rb'

def hand_builder *cards
  hand = []
  cards.each { | rank | hand << [rank, SUITS[Random.rand(4)]] }
  hand
end

describe "strategy" do

  before do

  end

  it "dealer should :hit when hand is less than 17" do
    hand = hand_builder 5, 5, 5
    expect(dealer_strategy hand).to eq :hit
  end

  it "dealer should :stand when hand is  17 or better" do
    hand = hand_builder 5, 5, 5, 5
    expect(dealer_strategy hand).to eq :stand
  end

  it "player should :hit when hand can't :bust (less than 12)" do
    hand = hand_builder 5, 6
    expect(player_strategy hand, [2, 'Clubs']).to eq :hit
    expect(player_strategy hand, [3, 'Clubs']).to eq :hit
    expect(player_strategy hand, [6, 'Clubs']).to eq :hit
    expect(player_strategy hand, [7, 'Clubs']).to eq :hit
    expect(player_strategy hand, ['Ace', 'Clubs']).to eq :hit
  end

  it "player should :hit 12 when up card is 2" do
    hand = hand_builder 5, 5, 2
    expect(player_strategy hand, [2, 'Clubs']).to eq :hit
  end

  it "player should :stand when dealer up card is a :bust card (3..6)" do
    hand = hand_builder 5, 5, 2
    expect(player_strategy hand, [3, 'Clubs']).to eq :stand
    expect(player_strategy hand, [6, 'Clubs']).to eq :stand
  end

  it "player should :hit when hand  can't beat dealer up card" do
    hand = hand_builder 5, 5, 2
    expect(player_strategy hand, [7, 'Clubs']).to eq :hit
    expect(player_strategy hand, ['Ace', 'Clubs']).to eq :hit
    hand = hand_builder 5, 5, 6
    expect(player_strategy hand, [7, 'Clubs']).to eq :hit
    expect(player_strategy hand, ['Ace', 'Clubs']).to eq :hit
  end

  it "player should :stand when hand is  17 or better" do
    hand = hand_builder 5, 5, 7
    expect(player_strategy hand, [2, 'Clubs']).to eq :stand
    expect(player_strategy hand, [3, 'Clubs']).to eq :stand
    expect(player_strategy hand, [6, 'Clubs']).to eq :stand
    expect(player_strategy hand, [7, 'Clubs']).to eq :stand
    expect(player_strategy hand, ['Ace', 'Clubs']).to eq :stand
    hand = hand_builder 5, 5, 'Ace'
    expect(player_strategy hand, [2, 'Clubs']).to eq :stand
    expect(player_strategy hand, [3, 'Clubs']).to eq :stand
    expect(player_strategy hand, [6, 'Clubs']).to eq :stand
    expect(player_strategy hand, [7, 'Clubs']).to eq :stand
    expect(player_strategy hand, ['Ace', 'Clubs']).to eq :stand
  end

end
