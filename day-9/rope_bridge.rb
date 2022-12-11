# frozen_string_literal: true

# A section of rope
class Rope
  attr_reader :head, :tail

  def initialize
    @head = [0, 0]
    @tail = [0, 0]
    @previous_tail = @tail
    @tail_positions = [[0, 0]]
  end

  def move(position)
    self.previous_tail = tail
    self.head = position
    return unless detached?

    self.tail = [new_row, new_column]
    tail_positions << tail
  end

  def tail_moved?
    tail != previous_tail
  end

  def unique_tail_positions
    tail_positions.uniq.count
  end

  private

  attr_accessor :previous_tail
  attr_reader :tail_positions
  attr_writer :head, :tail

  def detached?
    distance.any? { |coordinate| coordinate > 1 }
  end

  def distance
    head.zip(tail).map { |coordinates| (coordinates.first - coordinates.last).abs }
  end

  def new_row
    row_distance, column_distance = distance
    row_distance >= column_distance ? tail.first + coordinate_movement(head.first, tail.first) : head.first
  end

  def new_column
    row_distance, column_distance = distance
    row_distance <= column_distance ? tail.last + coordinate_movement(head.last, tail.last) : head.last
  end

  def coordinate_movement(head_coordinate, tail_coordinate)
    return (tail_coordinate + 1...head_coordinate).count if tail_coordinate <= head_coordinate

    -(head_coordinate + 1...tail_coordinate).count
  end
end

MOVEMENTS = {
  'R' => [0, 1],
  'L' => [0, -1],
  'U' => [1, 0],
  'D' => [-1, 0]
}.freeze

INSTRUCTIONS = File.read('input.txt').split("\n").map do |line|
  direction, steps = line.split
  [direction, steps.to_i]
end.freeze

def solve(ropes)
  INSTRUCTIONS.each { |instruction| follow(instruction, ropes: ropes) }
  ropes.last.unique_tail_positions
end

def follow(instruction, ropes:)
  direction, steps = instruction

  steps.times do
    target = ropes.first.head.zip(MOVEMENTS[direction]).map(&:sum)

    ropes.each do |rope|
      rope.move(target)
      break unless rope.tail_moved?

      target = rope.tail
    end
  end
end

def solve_first_puzzle
  solve([Rope.new])
end

def solve_second_puzzle
  solve(Array.new(9) { Rope.new })
end

solve_first_puzzle
solve_second_puzzle
