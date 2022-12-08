# frozen_string_literal: true

LINES = File.read('input.txt').split.map { |line| line.chars.map(&:to_i) }.freeze
COLUMNS = LINES.transpose.freeze

def visible?(tree, array, index)
  all_shorter?(tree, array[0...index]) ||
    all_shorter?(tree, array[index + 1...array.length])
end

def all_shorter?(tree, array)
  array.all? { |array_tree| array_tree < tree }
end

def score(tree, line, column, line_index, column_index)
  sequence_score(tree, line, column_index) * sequence_score(tree, column, line_index)
end

def sequence_score(tree, sequence, index)
  direction_score(tree, sequence[0...index].reverse) * direction_score(tree, sequence[index + 1...sequence.length])
end

def direction_score(tree, array)
  total = 0
  array.each do |array_tree|
    total += 1
    break if array_tree >= tree
  end
  total
end

def solve_first_puzzle
  visible_trees = LINES.map.with_index do |line, line_index|
    line.select.with_index do |tree, column_index|
      visible?(tree, line, column_index) ||
        visible?(tree, COLUMNS[column_index], line_index)
    end
  end
  visible_trees.flatten.length
end

def solve_second_puzzle
  scenic_scores = LINES.map.with_index do |line, line_index|
    line.map.with_index do |tree, column_index|
      score(tree, line, COLUMNS[column_index], line_index, column_index)
    end
  end
  scenic_scores.flatten.max
end

solve_first_puzzle
solve_second_puzzle
