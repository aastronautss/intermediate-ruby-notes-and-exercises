def my_select(array)
  selection = []
  iterator = 0

  while iterator < array.length
    element = array[iterator]
    selection << element if yield(element)
    iterator += 1
  end

  selection
end
