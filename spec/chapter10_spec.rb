require_relative '../chapter10.rb'

describe "my sort" do

  words = ["Fred", "Bill", "Alvin", "Zack", "Mark", "Bill", "John"]

  it "should sort an array" do
    expect(my_sort Array.new(words)).to eq Array.new(words).sort
  end

  it "should recursively sort an array" do
    expect(my_recursive_sort Array.new(words), []).to eq Array.new(words).sort
  end

end
