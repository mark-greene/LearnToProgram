
def push_smallest_and_remove unsorted, sorted
  smallest = unsorted.each_with_index.min
  sorted.push smallest[0]
  unsorted.delete_at smallest[1]
end

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

def my_dictionary_sort unsorted

  sorted = []
  lower_unsorted = []
  unsorted.each { |word| lower_unsorted.push word.downcase }

  while !unsorted.empty?
    index = lower_unsorted.each_with_index.min[1]
    sorted.push unsorted[index]
    unsorted.delete_at index
    lower_unsorted.delete_at index
  end
  sorted
end
