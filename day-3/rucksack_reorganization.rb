# frozen_string_literal: true

rucksacks = File.read('input.txt').split

def solve_first_puzzle(rucksacks)
  rucksacks.map do |rucksack|
    split_rucksack = split_rucksack(rucksack)
    found_item = (split_rucksack[0] & split_rucksack[1]).first
    calculate_value(found_item)
  end.sum
end

def solve_second_puzzle(rucksacks)
  sum = 0
  rucksacks.each_slice(3) do |group|
    split_group = group.map { |rucksack| rucksack.split('') }
    badge = (split_group[0] & split_group[1] & split_group[2]).first
    sum += calculate_value(badge)
  end
  sum
end

def split_rucksack(rucksack)
  first_half = rucksack.slice(0, rucksack.length / 2).split('')
  second_half = rucksack.slice(rucksack.length / 2, rucksack.length).split('')
  [first_half, second_half]
end

def calculate_value(character)
  character == character.downcase ? character.ord - 96 : character.ord - 38
end

solve_first_puzzle(rucksacks)
solve_second_puzzle(rucksacks)
