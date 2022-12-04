# frozen_string_literal: true

pairs = File.read('input.txt').split.map do |pair|
  pair.split(',').map do |elf|
    first_section, last_section = elf.split('-')
    first_section.to_i..last_section.to_i
  end
end

def solve_first_puzzle(pairs)
  pairs.map { |pair| pair.first.cover?(pair.last) || pair.last.cover?(pair.first) }.count(true)
end

def solve_second_puzzle(pairs)
  pairs.map { |pair| pair.first.cover?(pair.last.begin) || pair.last.cover?(pair.first.begin) }.count(true)
end

solve_first_puzzle(pairs)
solve_second_puzzle(pairs)
