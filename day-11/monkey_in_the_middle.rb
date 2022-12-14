# frozen_string_literal: true

require 'pry'

# A monkey
class Monkey
  attr_accessor :items
  attr_reader :divisible_by, :true_target, :false_target, :times_inspected

  def initialize(items:, operation:, divisible_by:, true_target:, false_target:)
    @items = items
    @operator, @operand = operation
    @divisible_by = divisible_by
    @true_target = true_target
    @false_target = false_target
    @times_inspected = 0
  end

  def inspect_item(item, base, puzzle:)
    self.times_inspected += 1
    current_operand = operand.is_a?(Integer) ? operand : item

    raised_worry = operator == '*' ? item * current_operand : item + current_operand
    puzzle == 'first' ? raised_worry / 3 : raised_worry % base
  end

  def throw_item(item, target)
    target.items << item
  end

  private

  attr_writer :times_inspected
  attr_reader :operator, :operand
end

def parse_items(items_info)
  items_info.split(':').last.split(',').map(&:to_i)
end

def parse_operation(operation_info)
  operation_info.split('old', 2).last.split.map { |part| /\A\d+\z/.match(part) ? part.to_i : part }
end

def parse_divisible_by(divisible_by_info)
  divisible_by_info.split(/divisible by /).last.to_i
end

def parse_target(target_info)
  target_info[-1].to_i
end

def monkey_factory(items_info, operation_info, divisible_by_info, true_target_info, false_target_info)
  items = parse_items(items_info)
  operation = parse_operation(operation_info)
  divisible_by = parse_divisible_by(divisible_by_info)
  true_target = parse_target(true_target_info)
  false_target = parse_target(false_target_info)

  Monkey.new(items: items,
             operation: operation,
             divisible_by: divisible_by,
             true_target: true_target,
             false_target: false_target)
end

def take_turn(monkey, monkeys, base, puzzle:)
  monkey.items.each do |item|
    item_worry_level = monkey.inspect_item(item, base, puzzle: puzzle)
    target = (item_worry_level % monkey.divisible_by).zero? ? monkey.true_target : monkey.false_target
    monkey.throw_item(item_worry_level, monkeys[target])
  end

  monkey.items = []
end

def solve(rounds, puzzle:)
  monkeys = INSTRUCTIONS.map do |monkey_info|
    items_info, operation_info, divisible_by_info, true_target_info, false_target_info = monkey_info
    monkey_factory(items_info, operation_info, divisible_by_info, true_target_info, false_target_info)
  end

  base = monkeys.map(&:divisible_by).reduce(&:*)
  rounds.times { monkeys.each { |monkey| take_turn(monkey, monkeys, base, puzzle: puzzle) } }

  monkeys.map(&:times_inspected).max(2).reduce(&:*)
end

def solve_first_puzzle
  solve(20, puzzle: 'first')
end

def solve_second_puzzle
  solve(10_000, puzzle: 'second')
end

INSTRUCTIONS = File.read('input.txt').split("\n\n").map { |monkey| monkey.split("\n").map(&:strip)[1..] }.freeze

solve_first_puzzle
solve_second_puzzle
