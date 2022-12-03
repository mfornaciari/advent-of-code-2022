# frozen_string_literal: true

rucksacks = File.read('input.txt').split

def solve_first_puzzle(rucksacks)
  rucksacks.sum do |rucksack|
    split_rucksack = split_rucksack(rucksack)
    found_item = (split_rucksack[0] & split_rucksack[1]).first
    calculate_value(found_item)
  end
end

def solve_second_puzzle(rucksacks)
  groups = rucksacks.each_slice(3).to_a
  groups.sum do |group|
    split_group = group.map(&:chars)
    badge = (split_group[0] & split_group[1] & split_group[2]).first
    calculate_value(badge)
  end
end

def split_rucksack(rucksack)
  first_half = rucksack[0...rucksack.size / 2].chars
  second_half = rucksack[rucksack.size / 2..rucksack.size].chars
  [first_half, second_half]
end

def calculate_value(character)
  character == character.downcase ? character.ord - 96 : character.ord - 38
end

solve_first_puzzle(rucksacks)
solve_second_puzzle(rucksacks)
