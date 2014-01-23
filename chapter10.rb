# Sort
def my_sort unsorted

  sorted = []
  while !unsorted.empty?
    push_smallest_and_remove unsorted, sorted
  end
  sorted
end

def my_recursive_sort unsorted, sorted

  if !unsorted.empty?
    push_smallest_and_remove unsorted, sorted
    my_recursive_sort unsorted, sorted
  end
  sorted
end

def push_smallest_and_remove unsorted, sorted
  smallest = unsorted.each_with_index.min
  sorted.push smallest[0]
  unsorted.delete_at smallest[1]
end

# Dictionary Sort
def my_dictionary_sort unsorted

  sorted = []
  while !unsorted.empty?
    index = find_smallest unsorted
    sorted.push unsorted[index]
    unsorted.delete_at index
  end
  sorted
end

def find_smallest unsorted

  smallest = unsorted[0].downcase
  position = 0
  unsorted.each_with_index do | value, index |
    if value.downcase < smallest
      smallest = unsorted[index].downcase
      position = index
    end
  end
  position
end


# English Number
def english_number number

  if number < 0 # No negative numbers.
    return 'Please enter a number that isn\'t negative.'
  end

  if number == 0
    return 'zero'
  end

  number_string = '' # This is the string we will return.

  # "left" is how much of the number we still have left to write out.
  # "write" is the part we are writing out right now.
  left = number

  number_string, left = decimal_place 1000000000000, 'trillion', number_string, left
  number_string, left = decimal_place 1000000000, 'billion', number_string, left
  number_string, left = decimal_place 1000000, 'million', number_string, left
  number_string, left = decimal_place 1000, 'thousand', number_string, left
  number_string, left = decimal_place 100, 'hundred', number_string, left

  number_string, left = tens_place number_string, left

  number_string, left = ones_place number_string, left

  # Now we just return "number_string"...
  return number_string
end

def  decimal_place number, name, number_string, left

  write = left/number
  left = left - write*number
  if write > 0
    decimal = english_number write
    number_string = number_string + decimal + ' ' +name
    if left > 0
      number_string = number_string + ' '
    end
  end
  return number_string, left
end

def tens_place number_string, left

  tens = ['ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']
  teens = ['eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']

  write = left/10 # How many tens left?
  left = left - write*10 # Subtract off those tens.

  if write > 0
    if ((write == 1) and (left > 0))
      # Since we can't write "tenty-two" instead of "twelve",
      # we have to make a special exception for these.
      number_string = number_string + teens[left-1]
      # Since we took care of the digit in the ones place already,
      # we have nothing left to write.
      left = 0
    else
      number_string = number_string + tens[write-1]
    end

    if left > 0
      # So we don't write 'sixtyfour'...
      number_string = number_string + '-'
    end
  end
  return number_string, left
end

def ones_place  number_string, left

  ones = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

  write = left # How many ones left to write out?
  left = 0 # Subtract off those ones.

  if write > 0
    number_string = number_string + ones[write]
  end
  return number_string, left
end
