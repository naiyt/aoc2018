def marble_high_score(game_rules)
  match = game_rules.match(/(\d+) players; last marble is worth (\d+) points/)
  raise "Invalid input string" unless match
  num_players = match[1].to_i
  num_marbles = match[2].to_i
  players = Array.new(num_players, 0)
  game_board = [] of Int32
  current_marble_value = 0
  current_marble_position = 0

  while current_marble_value < num_marbles
    players.each_with_index do |_p, index|
      if current_marble_value != 0 && current_marble_value % 23 == 0
        players[index] += current_marble_value
        current_marble_position -= 7
        current_marble_position = game_board.size + current_marble_position if current_marble_position < 0
        players[index] += game_board.delete_at(current_marble_position)
      else
        current_marble_position += 2 unless game_board.size == 0
        current_marble_position -= game_board.size if current_marble_position > game_board.size
        game_board.insert(current_marble_position, current_marble_value)
      end

      current_marble_value += 1
      break if current_marble_value > num_marbles
    end
  end

  players.max
end
