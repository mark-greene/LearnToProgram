require_relative '../chapter9.rb'

describe "old roman numeral" do

  it "should convert 4 to IIII" do
    expect old_roman_numeral(4) == "IIII"
  end
  it "should convert 9 to VIIII" do
    expect old_roman_numeral(9) == "VIIII"
  end
  it "should convert 19 to XVIIII" do
    expect old_roman_numeral(19) == "XVIIII"
  end
  it "should convert 69 to LXVIIII" do
    expect old_roman_numeral(69) == "LXVIIII"
  end
  it "should convert 169 to CLXVIIII" do
    expect old_roman_numeral(169) == "CLXVIIII"
  end
  it "should convert 669 to DCLXVIIII" do
    expect old_roman_numeral(669) == "DCLXVIIII"
  end
  it "should convert 1669 to MDCLXVIIII" do
    expect old_roman_numeral(1669) == "MDCLXVIIII"
  end
  it "should convert 2777 to MMDCCLXXVII" do
    expect old_roman_numeral(2777) == "MMDCCLXXVII"
  end

end

describe "roman numeral" do

  it "should convert 4 to IV" do
    expect old_roman_numeral(4) == "IV"
  end
  it "should convert 9 to IX" do
    expect old_roman_numeral(9) == "IX"
  end
  it "should convert 19 to XIX" do
    expect old_roman_numeral(19) == "XIX"
  end
  it "should convert 69 to LXIX" do
    expect old_roman_numeral(69) == "LXIX"
  end
  it "should convert 169 to CLXIX" do
    expect old_roman_numeral(169) == "CLXIX"
  end
  it "should convert 669 to DCLXIX" do
    expect old_roman_numeral(669) == "DCLXIX"
  end
  it "should convert 1669 to MDCLXIX" do
    expect old_roman_numeral(1669) == "MDCLXIX"
  end
  it "should convert 2777 to MMDCCLXXVII" do
    expect old_roman_numeral(2777) == "MMDCCLXXVII"
  end

end
