input = open("input.txt").readlines()

elves = {}
current_elf = 0

for item in input:
  if item == '\n':
    current_elf += 1
    continue
  else:
    value = int(item.replace('\n', ''))
    if current_elf in elves.keys():
      elves[current_elf] += value
    else:
      elves[current_elf] = value

max_elf = max(elves.values())
print(max_elf)
