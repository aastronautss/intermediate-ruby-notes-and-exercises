def my_reduce(array, init = 0)
  mem = init

  array.each do |element|
    mem = yield(mem, element)
  end

  mem
end

array = [1, 2, 3, 4, 5]

puts my_reduce(array) { |acc, num| acc + num }
puts my_reduce(array, 10) { |acc, num| acc + num }
puts my_reduce(array) { |acc, num| acc + num if num.odd? }
