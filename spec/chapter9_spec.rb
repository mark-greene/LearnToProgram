require_relative '../chapter9.rb'

describe "old roman numeral" do

  it "should convert 4 to IIII" do
    expect(old_roman_numeral(4)).to eq "IIII"
  end
  it "should convert 9 to VIIII" do
    expect(old_roman_numeral(9)).to eq "VIIII"
  end
  it "should convert 19 to XVIIII" do
    expect(old_roman_numeral(19)).to eq "XVIIII"
  end
  it "should convert 69 to LXVIIII" do
    expect(old_roman_numeral(69)).to eq "LXVIIII"
  end
  it "should convert 169 to CLXVIIII" do
    expect(old_roman_numeral(169)).to eq "CLXVIIII"
  end
  it "should convert 669 to DCLXVIIII" do
    expect(old_roman_numeral(669)).to eq "DCLXVIIII"
  end
  it "should convert 1669 to MDCLXVIIII" do
    expect(old_roman_numeral(1669)).to eq "MDCLXVIIII"
  end
  it "should convert 2777 to MMDCCLXXVII" do
    expect(old_roman_numeral(2777)).to eq "MMDCCLXXVII"
  end

end

describe "roman numeral" do

  it "should convert 4 to IV" do
    expect(roman_numeral(4)).to eq "IV"
  end
  it "should convert 9 to IX" do
    expect(roman_numeral(9)).to eq "IX"
  end
  it "should convert 19 to XIX" do
    expect(roman_numeral(19)).to eq "XIX"
  end
  it "should convert 69 to LXIX" do
    expect(roman_numeral(69)).to eq "LXIX"
  end
  it "should convert 169 to CLXIX" do
    expect(roman_numeral(169)).to eq "CLXIX"
  end
  it "should convert 669 to DCLXIX" do
    expect(roman_numeral(669)).to eq "DCLXIX"
  end
  it "should convert 1669 to MDCLXIX" do
    expect(roman_numeral(1669)).to eq "MDCLXIX"
  end
  it "should convert 2777 to MMDCCLXXVII" do
    expect(roman_numeral(2777)).to eq "MMDCCLXXVII"
  end

end
