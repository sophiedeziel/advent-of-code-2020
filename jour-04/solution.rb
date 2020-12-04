require 'pry'
passports = File.open('input.txt', 'r').map(&:to_s).join("").split("\n\n").map do |passport|
  passport.split("\n").join(' ').split(' ').each_with_object({}) do |field, hash|
    key, value = field.split(':')
    hash[key] = value
  end
end

passports = passports.select do |passport|
  ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].all? do |key|
    !!passport[key]
  end
end

puts "Partie 1: #{passports.count}"

part2 = passports.count do |passport|
  valid = passport.all? do |key, value|
    case key
    when "byr"
      value.to_i >= 1920 && value.to_i <= 2002
    when "iyr"
      value.to_i >= 2010 && value.to_i <= 2020
    when "eyr"
      value.to_i >= 2020 && value.to_i <= 2030
    when "hgt"
      if value[-2,2] == "cm"
        value.to_i >= 150 && value.to_i <= 193
      elsif value[-2,2] == "in"
        value.to_i >= 59 && value.to_i <= 76
      else
        false
      end
    when "hcl"
      value.size == 7 && /\A#[a-f0-9]{6}\z/ === value
    when "ecl"
      %w(amb blu brn gry grn hzl oth).include? value
    when "pid"
      value.size == 9 && /\d{9}/ === value
    when "cid"
      true
    end
  end
  valid
end

puts "Partie 2: #{part2}"