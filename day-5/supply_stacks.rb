# frozen_string_literal: true

input = File.read('input.txt').split("\n\n").freeze
instructions = input.last.split("\n").map do |instruction|
  instruction.split.map(&:to_i).filter(&:nonzero?)
end

def crates(input)
  input.first.split("\n")[0...-1].map do |line|
    split_line = line.chars.each_slice(4).map do |element|
      element.join.strip.gsub(/\W/, '')
    end
    split_line + [''] * (9 - split_line.length)
  end
end

def columns(crates)
  crates.transpose.map { |column| column.reject(&:empty?) }
end

def move_crates(instructions, columns, crane: 9000)
  resulting_columns = columns
  instructions.each do |instruction|
    number_of_boxes, column_from, column_to = instruction
    moved_crates = resulting_columns[column_from - 1].shift(number_of_boxes)
    moved_crates = moved_crates.reverse if crane == 9001
    moved_crates.each { |crate| resulting_columns[column_to - 1].unshift(crate) }
  end
  resulting_columns
end

def solve_first_puzzle(input, instructions)
  columns = columns(crates(input))
  final_columns = move_crates(instructions, columns)
  final_columns.map(&:first).join
end

def solve_second_puzzle(input, instructions)
  columns = columns(crates(input))
  final_columns = move_crates(instructions, columns, crane: 9001)
  final_columns.map(&:first).join
end

solve_first_puzzle(input, instructions)
solve_second_puzzle(input, instructions)
