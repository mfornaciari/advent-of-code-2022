# fronzen_string_literal: true

# The clock circuit's CPU
class CPU
  attr_reader :signal_strengths

  def initialize
    @current_cycle = 0
    @x = 1
    @signal_strengths = []
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
      signal_strengths << x * current_cycle
    end
  end
end

def follow(instruction, value, cpu)
  if instruction == 'addx'
    cpu.addx(value)
  else
    cpu.noop
  end
end

def solve_first_puzzle
  cpu = CPU.new

  INSTRUCTIONS.each do |line|
    instruction, value = line
    follow(instruction, value, cpu)
  end

  cpu.signal_strengths[(19..220).step(40)].sum
end

INSTRUCTIONS = File.read('input.txt').split("\n").map do |line|
  instruction, value = line.split
  [instruction, value.to_i]
end.freeze

solve_first_puzzle
