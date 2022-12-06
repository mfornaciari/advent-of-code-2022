# frozen_string_literal: true

input = File.read('input.txt').split("\n\n")

crates = input.first.split("\n")[0...-1].map do |line|
  split_line = line.chars.each_slice(4).map do |element|
    element.join.strip.gsub(/\W/, '')
  end
  split_line + [''] * (9 - split_line.length)
end

columns = crates.transpose.map { |column| column.reject(&:empty?) }

instructions = input.last.split("\n").map do |instruction|
  instruction.split.map(&:to_i).filter(&:nonzero?)
end

def move_crates(instructions, columns)
  resulting_columns = columns
  instructions.each do |instruction|
    number_of_boxes, column_from, column_to = instruction
    moved_crates = resulting_columns[column_from - 1].shift(number_of_boxes)
    moved_crates.each { |crate| resulting_columns[column_to - 1].unshift(crate) }
  end
  resulting_columns
end

def solve_first_puzzle(instructions, columns)
  final_columns = move_crates(instructions, columns)
  final_columns.map(&:first).join
end

solve_first_puzzle(instructions, columns)
