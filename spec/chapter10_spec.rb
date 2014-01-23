require_relative '../chapter10.rb'

describe "my_sort" do

  words = ["Fred", "Bill", "Alvin", "Zack", "Mark", "Bill", "John"]
  words2 = ["Fred", "bill", "Alvin", "zack", "Mark", "Bill", "john"]
  sorted_words2 = ["Alvin", "bill", "Bill", "Fred", "john", "Mark", "zack"]

  it "should sort an array" do
    expect(my_sort Array.new(words)).to eq Array.new(words).sort
  end

  it "should sort an empty array" do
    expect(my_sort  []).to eq []
  end

  it "should sort a one element array" do
    expect(my_sort ["one"]).to eq ["one"]
  end

  it "should recursively sort an array" do
    expect(my_recursive_sort Array.new(words), []).to eq Array.new(words).sort
  end

  it "should dictionary sort an array" do
    expect(my_dictionary_sort Array.new(words2)).to eq sorted_words2
  end

end

describe "english_number" do

  it "should convert to zero" do
    expect(english_number(0)).to eq "zero"
  end
  it "should convert to nine" do
    expect(english_number(9)).to eq "nine"
  end
  it "should convert to ten" do
    expect(english_number(10)).to eq "ten"
  end
  it "should convert to eleven" do
    expect(english_number(11)).to eq "eleven"
  end
  it "should convert to seventeen" do
    expect(english_number(17)).to eq "seventeen"
  end
  it "should convert to thirty-two" do
    expect(english_number(32)).to eq "thirty-two"
  end
  it "should convert to eighty-eight" do
    expect(english_number(88)).to eq "eighty-eight"
  end
  it "should convert to ninety-nine" do
    expect(english_number(99)).to eq "ninety-nine"
  end
  it "should convert to one hundred" do
    expect(english_number(100)).to eq "one hundred"
  end
  it "should convert to one hundred one" do
    expect(english_number(101)).to eq "one hundred one"
  end
  it "should convert to two hundred thirty-four" do
    expect(english_number(234)).to eq "two hundred thirty-four"
  end
  it "should convert to three thousand two hundred eleven" do
    expect(english_number(3211)).to eq "three thousand two hundred eleven"
  end
  it "should convert to nine hundred ninety-nine thousand nine hundred ninety-nine" do
    expect(english_number(999999)).to eq "nine hundred ninety-nine thousand nine hundred ninety-nine"
  end
  it "should convert to one million" do
    expect(english_number(1000000)).to eq "one million"
  end
  it "should convert to one billion" do
    expect(english_number(1000000000)).to eq "one billion"
  end
  it "should convert to one trillion" do
    expect(english_number(1000000000000)).to eq "one trillion"
  end

end
