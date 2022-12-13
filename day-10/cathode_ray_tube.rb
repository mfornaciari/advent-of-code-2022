# frozen_string_literal: true

# The CRT device
class Device
  attr_reader :signal_strengths, :screen

  def initialize
    @current_cycle = 0
    @x = 1
    @signal_strengths = []
    @screen = Array.new(6) { '.' * 40 }
  end

  def addx(value)
    tick(2)
    self.x += value
  end

  def noop
    tick(1)
  end

  private

  attr_accessor :current_cycle, :x

  def tick(value)
    value.times do
      self.current_cycle += 1
      draw
      signal_strengths << x * current_cycle
    end
  end

  def draw
    pixel_index = (current_cycle - 1) % 40
    current_line = current_cycle / 40
    sprite_center = x - 1..x + 1

    screen[current_line][pixel_index] = '#' if sprite_center.cover?(pixel_index)
  end
end

def follow(instruction, value)
  if instruction == 'addx'
    DEVICE.addx(value)
  else
    DEVICE.noop
  end
end

def solve_first_puzzle
  DEVICE.signal_strengths[(19..220).step(40)].sum
end

def solve_second_puzzle
  DEVICE.screen
end

DEVICE = Device.new

INSTRUCTIONS = File.read('input.txt').split("\n").map do |line|
  instruction, value = line.split
  [instruction, value.to_i]
end.freeze

INSTRUCTIONS.each do |line|
  instruction, value = line
  follow(instruction, value)
end

solve_first_puzzle
solve_second_puzzle
