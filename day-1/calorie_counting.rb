# frozen_string_literal: true

elves = File.read('input.txt').split("\n\n")

total_calories = elves.map { |elf_calories| elf_calories.split("\n").map(&:to_i).sum }

total_calories.max(3).sum
