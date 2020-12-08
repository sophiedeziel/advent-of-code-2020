require 'pry'

class Solution
  attr_accessor :accumulator, :operations, :cursor

  def initialize(filename)
    @operations = []
    @cursor = 0
    @accumulator = 0

    File.open(filename, 'r').each do |line|
      match = line.match /(?<opcode>\w{3}) (?<value>[+-]\d+)/
      @operations << [match[:opcode], match[:value].to_i]
    end
  end

  def execute_next
    opcode, value = @operations[@cursor]
    case opcode
    when 'nop'
    when 'acc'
      @accumulator += value
    when 'jmp'
      @cursor += value
    end
    @cursor += 1 unless opcode == 'jmp'
  end

  def execute_program
    reset
    visited_lines = []

    while operations[cursor] do
      raise if visited_lines.include? @cursor
      visited_lines << cursor
      execute_next
    end

    return @cursor == @operations.size
  rescue
    return false
  end

  def reset
    @cursor = 0
    @accumulator = 0
  end
end

solution = Solution.new('input.txt')

solution.execute_program

puts "Partie 1: #{solution.accumulator}"

original_program = solution.operations.dup

original_program.each_with_index do |op, index|
  next if op[0] == 'acc'

  solution.operations = original_program.map &:dup
  solution.operations[index][0] = solution.operations[index][0] == 'nop' ? 'jmp' : 'nop'

  break if solution.execute_program
end

puts "Partie 2: #{solution.accumulator}"