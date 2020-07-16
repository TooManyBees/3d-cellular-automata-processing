# Drop this in the body of `automaton2.pde` function

puts "boolean automaton2(int[] neighborhood, boolean[] space) {"
puts "  int value = evalNeighborhood(neighborhood, space);"
permutations = 2 ** 9
(0...permutations).each do |n|
    puts "  final int b%09b = 0b%09b;" % [n, n]
end
puts "  switch (value) {"
(0...permutations).each do |n|
    t = rand(2) > 0
    puts "    case b%09b:\n      return %s;" % [n, t]
end
puts "    default:\n      return false;"
puts "  }"
puts "}"
