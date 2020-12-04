
def slope(x, y = 1)
  position = 0
  solution = File.open('input.txt', 'r').each_with_index.count do |line, index|
    line.strip!
    if (index % y) != 0 
      false 
    else
      tree = line[position % line.size] == '#'
      position += x
      tree
    end
  end
end

puts "Partie 1: #{slope(3,1)}"
part2 = [[1,1], [3,1], [5,1], [7,1], [1,2]].map { |coordinates| slope(*coordinates) }

puts "Partie 2: #{part2.reduce(1, :*)}"

