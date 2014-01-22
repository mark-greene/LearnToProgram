
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
