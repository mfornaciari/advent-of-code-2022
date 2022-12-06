# frozen_string_literal: true

SEQUENCE = File.read('input.txt').chars.freeze

def find_distinct_characters(number)
  number + SEQUENCE.each_cons(number).to_a.index { |slice| slice.uniq == slice }
end

def solve_first_puzzle
  find_distinct_characters(4)
end

def solve_second_puzzle
  find_distinct_characters(14)
end

solve_first_puzzle
solve_second_puzzle
