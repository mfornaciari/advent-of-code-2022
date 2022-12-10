# frozen_string_literal: true

# Solves day 9 puzzles
class DayNineSolver
  def self.execute
    new.solve_first_puzzle
  end

  def solve_first_puzzle
    INSTRUCTIONS.each do |instruction|
      direction, steps = instruction

      steps.times do
        move_head(direction)
        move_tail if detached?
        visited_positions << tail_position
      end
    end
    visited_positions.uniq.count
  end

  private

  INSTRUCTIONS = File.read('input.txt').split("\n").map do |line|
    direction, steps = line.split
    [direction, steps.to_i]
  end.freeze

  MOVEMENTS = {
    'R' => [0, 1],
    'L' => [0, -1],
    'U' => [1, 0],
    'D' => [-1, 0]
  }.freeze

  attr_accessor :head_position, :tail_position, :visited_positions

  def initialize
    @head_position = [0, 0]
    @tail_position = [0, 0]
    @visited_positions = []
  end

  def move_head(direction)
    self.head_position = head_position.zip(MOVEMENTS[direction]).map(&:sum)
  end

  def detached?
    head_row, head_column = head_position
    tail_row, tail_column = tail_position

    distance(head_row, tail_row) > 1 ||
      distance(head_column, tail_column) > 1
  end

  def distance(point, other_point)
    (point - other_point).abs
  end

  def move_tail
    head_row, head_column = head_position
    tail_row, tail_column = tail_position
    row_distance = distance(head_row, tail_row)
    column_distance = distance(head_column, tail_column)
    self.tail_position = if row_distance > column_distance
                           [tail_row + tail_movement(head_row, tail_row, row_distance), head_column]
                         else
                           [head_row, tail_column + tail_movement(head_column, tail_column, column_distance)]
                         end
  end

  def tail_movement(head_point, tail_point, distance)
    head_point > tail_point ? distance - 1 : 1 - distance
  end
end

DayNineSolver.execute
