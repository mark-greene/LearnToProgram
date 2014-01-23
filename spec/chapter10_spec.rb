require_relative '../chapter10.rb'

describe "my sort" do

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
