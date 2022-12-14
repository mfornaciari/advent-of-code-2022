# frozen_string_literal: true

VALUES = { 'rock' => 1, 'paper' => 2, 'scissors' => 3 }.freeze
BEATEN_CHOICES = { 'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper' }.freeze
GUIDE = File.read('input.txt').each_line.to_a.freeze

def calculate_points(my_choice, their_choice)
  points = VALUES[my_choice]
  return (points + 3) if result(my_choice, their_choice) == 'draw'
  return (points + 6) if result(my_choice, their_choice) == 'win'

  points
end

def result(my_choice, their_choice)
  return 'draw' if my_choice == their_choice
  return 'win' if BEATEN_CHOICES[my_choice] == their_choice

  'loss'
end

def translate(choice)
  case choice
  when /A|X/
    'rock'
  when /B|Y/
    'paper'
  else
    'scissors'
  end
end

def find_my_choice(their_choice, result:)
  case result
  when 'X'
    BEATEN_CHOICES[their_choice]
  when 'Y'
    their_choice
  else
    BEATEN_CHOICES.key(their_choice)
  end
end

def solve_first_puzzle
  GUIDE.sum do |round|
    their_choice, my_choice = round.split
    calculate_points(translate(my_choice), translate(their_choice))
  end
end

def solve_second_puzzle
  GUIDE.sum do |round|
    their_choice, result = round.split
    my_choice = find_my_choice(translate(their_choice), result: result)
    calculate_points(my_choice, translate(their_choice))
  end
end

solve_first_puzzle
solve_second_puzzle
