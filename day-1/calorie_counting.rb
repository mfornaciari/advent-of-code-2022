# frozen_string_literal: true

ELVES = File.read('input.txt').split("\n\n").freeze
TOTAL_CALORIES = ELVES.map { |elf_calories| elf_calories.split.map(&:to_i).sum }.freeze

def solve_first_puzzle
  TOTAL_CALORIES.max
end

def solve_second_puzzle
  TOTAL_CALORIES.max(3).sum
end

solve_first_puzzle
solve_second_puzzle
