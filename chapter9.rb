
def old_roman_numeral  number
  conversion = {
    1    => 'I',
    5    => 'V',
    10   => 'X',
    50   => 'L',
    100  => 'C',
    500  => 'D',
    1000 => 'M'
  }

  convert_to_roman_numeral conversion, number
end

def roman_numeral number
  conversion = {
    1    => 'I',
    4    => 'IV',
    5    => 'V',
    9    => 'IX',
    10   => 'X',
    40   => 'XL',
    50   => 'L',
    90   => 'XC',
    100  => 'C',
    400  => 'CD',
    500  => 'D',
    900  => 'CM',
    1000 => 'M'
  }

  convert_to_roman_numeral conversion, number
end

# Found Algorythms
def convert_to_roman_numeral conversion, number
  result = ''
  conversion.keys.reverse.each do |decimal|
    while number >= decimal
      number -= decimal
      result += conversion[decimal]
    end
  end
  result
end

def convert_to_roman_numeral2 conversion, number
  result = ''
  conversion.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << conversion[divisor] * quotient
    number = modulus
  end
  result
end
