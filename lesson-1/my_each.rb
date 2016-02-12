def my_each(array)
  iterator = 0

  while iterator < array.length
    yield(array[iterator])
    iterator += 1
  end

  arry
end

my_each([1, 2, 3, 4, 5]) { |num| puts num }
