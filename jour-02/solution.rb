require 'pry'

counts = File.open('input.txt', 'r').map do |line|
  match = line.match /^^(\d+)-(\d+) (.): (.+)/

  min = match[1].to_i
  max = match[2].to_i
  letter = match[3]
  pw = match[4]

  [
    pw.count(letter) >= min &&  pw.count(letter) <= max,
    pw[min + 1] == letter &&  pw[max + 1] != letter
  ]
  
end

puts "Partie 1: #{counts.count &:first}"
puts "Partie 2: #{counts.count &:last}"