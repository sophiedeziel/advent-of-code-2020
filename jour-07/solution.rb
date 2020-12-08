require 'pry'

class BagRules
  def initialize(filename)
    @rules = File.open(filename, 'r').each_with_object({}) do |line, hash|
      next if line.match(/bags contain no other bags./) 
      
      container = line.match( /(?<color>\w+\s\w+) bags contain/)[:color]

      content = line.split(',').each_with_object({}) do |parts, hash|
        match = parts.match(/(?<quantity>\d+) (?<color>\w+\s\w+) bags?,?/)
        hash.merge!({ match[:color] => match[:quantity].to_i })
      end

      hash[container] = content
    end
  end

  def get_parents_bags(color)
    @rules.flat_map do |rule, children|
      if children.find{|k,v| k == color}
        [rule] + get_parents_bags(rule)
      end
    end.compact.uniq
  end

  def get_contained_bags(color)
    return 1 if @rules[color].nil?

    @rules[color].map do |col, number| 
      number * get_contained_bags(col)
    end.sum + 1
  end
end

rules = BagRules.new('input.txt')

puts "Partie 1: #{rules.get_parents_bags("shiny gold").count}"

puts "Partie 2: #{rules.get_contained_bags("shiny gold") - 1}"