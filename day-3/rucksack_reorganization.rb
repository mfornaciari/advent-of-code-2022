# frozen_string_literal: true

RUCKSACKS = File.read('input.txt').split.freeze

def calculate_value(character)
  character == character.downcase ? character.ord - 96 : character.ord - 38
end

def solve_first_puzzle
  RUCKSACKS.sum do |rucksack|
    first_half, second_half = rucksack.chars.each_slice(rucksack.size / 2).to_a
    found_item = (first_half & second_half).first
    calculate_value(found_item)
  end
end

def solve_second_puzzle
  RUCKSACKS.each_slice(3).to_a.sum do |group|
    first_elf, second_elf, third_elf = group.map(&:chars)
    badge = (first_elf & second_elf & third_elf).first
    calculate_value(badge)
  end
end

solve_first_puzzle
solve_second_puzzle
