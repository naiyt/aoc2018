ALIVE = '#'
DEAD  = '.'

def game_of_pots(input)
  input = input.split("\n").map { |r| r.strip }
  initial_state = input[0][(15..input[0].size-1)]
  rules = {} of Tuple(Char, Char, Char, Char, Char) => Char

  input[(2..input.size-1)].each do |rule|
    pots = Tuple(Char, Char, Char, Char, Char).from(rule[0..4].chars)
    rules[pots] = rule[-1]
  end

  pots = {} of Int32 => Char
  initial_state.chars.each_with_index { |pot, index| pots[index] = pot }
  max_alive = pots.select { |k, v| v == ALIVE }.keys.max
  min_alive = pots.select { |k, v| v == ALIVE }.keys.min

  prev_generation_count = curr_generation_count = 0

  2_000.times do |i|
    next_generation = {} of Int32 => Char

    next_max_alive = Int32::MIN
    next_min_alive = Int32::MAX

    (min_alive-3..max_alive+3).each do |location|
      surrounding_pots = {pots[location-2]? || DEAD, pots[location-1]? || DEAD, pots[location]? || DEAD, pots[location+1]? || DEAD, pots[location+2]? || DEAD}
      next_generation[location] = rules[surrounding_pots]? || DEAD
      next_min_alive = location if next_generation[location] == ALIVE && location < next_min_alive
      next_max_alive = location if next_generation[location] == ALIVE && location > next_max_alive
    end

    min_alive = next_min_alive
    max_alive = next_max_alive
    prev_generation_count = pots.select { |pot, status| status == ALIVE }.keys.sum
    curr_generation_count = next_generation.select { |pot, status| status == ALIVE }.keys.sum
    pots = next_generation
  end

  increment_amount = curr_generation_count - prev_generation_count
  (50_000_000_000 - 2_000) * increment_amount + curr_generation_count
end
