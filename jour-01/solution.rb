@entries = File.open('input.txt', 'r').map &:to_i

def find_numbers_that_sums(total, results = 2)
  to_find = 0

  entry = @entries.find do |n|
    to_find = total - n
    
    if results == 2
      @entries.include?(to_find)
    else
      to_find = find_numbers_that_sums(to_find, results - 1)
    end
  end

  return false unless entry

  [entry, to_find].flatten
end

puts "Partie 1 : #{find_numbers_that_sums(2020).reduce(1, :*)}"

puts "Partie 2 : #{find_numbers_that_sums(2020, 3).reduce(1, :*)}"