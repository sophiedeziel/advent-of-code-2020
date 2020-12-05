def binary_search(number, string, lower_half)
  string.chars.reduce([0, number - 1]) do |range, c|
    half = ((range.last - range.first) / 2.0).ceil
    if c == lower_half
      range[1] -= half
    else
      range[0] += half
    end
    range
  end.first
end

def find_seat_id(seat)
  return unless seat
  row = binary_search(128, seat[0, 7], 'F')
  column = binary_search(8, seat[7, 3], 'L')

  seat_id(row, column)
end

def seat_id(row, column)
  row * 8 + column
end

seat_ids = File.open('input.txt', 'r').map do |line|
  find_seat_id(line.strip!)
end.compact

adjacents = seat_ids.sort.each_slice(2).find { |id, next_id| id + 2 == next_id }

puts "Partie 1: #{seat_ids.sort.last}"
puts "Partie 2: #{adjacents.first + 1}"
