# frozen_string_literal: true

class NoSpaceLeftOnDevice
  OUTPUT = File.read('input.txt').split("\n")[1..].freeze

  def initialize
    @tree = { '/' => { size: 0 } }
    @path = ['/']
    @current_dir = @tree['/']
    @sum_100k_dirs = 0
  end

  def solve_first_puzzle
    assemble_tree
    calculate_size(@tree['/'])
    @sum_100k_dirs
  end

  private

  def assemble_tree
    OUTPUT.each do |line|
      if command?(line)
        handle_command(line)
      elsif dir?(line)
        handle_dir(line)
      else
        handle_file(line)
      end
    end
  end

  def command?(line)
    line.start_with?('$')
  end

  def dir?(line)
    line.start_with?('dir')
  end

  def handle_command(line)
    command = get_command(line)
    return unless move?(command)

    move_in?(command) ? move_in(command.last) : move_out
  end

  def get_command(line)
    line.tr('$', '').split
  end

  def move?(command)
    command.first == 'cd'
  end

  def move_in?(move_command)
    move_command.last != '..'
  end

  def move_in(dir)
    @path << dir
    @current_dir = @current_dir[dir]
  end

  def move_out
    @path.pop
    @current_dir = @tree.dig(*@path)
  end

  def handle_dir(line)
    dir = get_dir(line)
    create_dir(dir) unless dir_exists?(dir)
  end

  def get_dir(line)
    line.split.last
  end

  def dir_exists?(dir)
    @current_dir.key?(dir)
  end

  def create_dir(dir)
    @current_dir[dir] = { size: 0 }
  end

  def handle_file(line)
    size = line.split.first
    @current_dir[:size] += size.to_i
  end

  def calculate_size(dir)
    dir.each_value { |item| dir[:size] += calculate_size(item) if item.is_a?(Hash) }
    @sum_100k_dirs += dir[:size] if dir[:size] <= 100_000
    dir[:size]
  end
end

NoSpaceLeftOnDevice.new.solve_first_puzzle
