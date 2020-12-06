require 'pry'
groups = File.open('input.txt', 'r').map(&:to_s).join("").split("\n\n")

counts = groups.map{ |answers| (answers.chars.uniq - ["\n"]).count }

puts "Partie 1: #{counts.sum}"

counts = groups.map do |answers| 
  unique = answers.chars.uniq - ["\n"]
  unique.count { |ans| answers.split("\n").all? { |set| set.include? ans} }
end

puts "Partie 2: #{counts.sum}"