ALIVE = '#'
DEAD  = '.'

def surrounding_pots(location, pots)
  character = ->(location : Int32) { pots.has_key?(location) ? pots[location] : DEAD }
  [character.call(location-2), character.call(location-1), character.call(location), character.call(location+1), character.call(location+2)].join
end

def game_of_pots(input, generations = 20)
  input = input.split("\n").map { |r| r.strip }
  initial_state = input[0][(15..input[0].size-1)]
  rules = input[(2..input.size-1)]

  pots = {} of Int32 => Char
  initial_state.chars.each_with_index { |pot, index| pots[index] = pot }

  generations.times do
    next_generation = {} of Int32 => Char
    max = pots.select { |k, v| v == ALIVE }.keys.max
    min = pots.select { |k, v| v == ALIVE }.keys.min
    (min-3...min).each { |loc| pots[loc] = DEAD }
    (max+1..max+3).each { |loc| pots[loc] = DEAD }
    pots.each do |location, _status|
      surrounding_pots = surrounding_pots(location, pots)
      matching_rule = rules.find { |rule| rule[(0..4)] == surrounding_pots }
      next_generation[location] = !matching_rule.nil? && matching_rule[-1] == ALIVE ? ALIVE : DEAD
    end
    pots = next_generation
  end

  pots.select { |pot, status| status == ALIVE }.keys.sum
end
