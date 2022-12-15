# frozen_string_literal: true

def get_spot(spot_letter)
  target_line = MAP.find { |line| line.include?(spot_letter) }
  line_index = MAP.index(target_line)
  column_index = target_line.index(spot_letter)
  [line_index, column_index]
end

def solve
  start = get_spot('S')
  destination = get_spot('E')
  adjacent_spots = {}
  MAP.each_with_index do |line, line_index|
    consecutive_spots = [nil, *line, nil].each_cons(3).to_a
    consecutive_spots.each_with_index do |spots, column_index|
      adjacent_spots[[line_index, column_index]] = { horizontal: spots }
    end
  end
  p adjacent_spots
end

MAP = File.read('test_input.txt').split.map do |line|
  line.chars.map { |char| char == char.downcase ? char.ord : char }
end.freeze

COLUMNS = MAP.transpose.freeze

solve
