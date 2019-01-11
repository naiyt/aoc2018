class Point
  property x, y

  def initialize(@x : Int32, @y : Int32)
  end
end

class Character
  property hp, x, y, attack_power

  def initialize(@x : Int32, @y : Int32, @attack_power = 3)
    @hp = 200
  end

  def point
    Point.new(x, y)
  end

  def dead?
    hp <= 0
  end
end

class Goblin < Character
end

class Elf < Character
end

class Game
  property game_board : Array(Array(String|Character))
  property characters : Array(Character)
  property ticks : Int32
  property raw_input : String
  property elves_count : Int32

  def initialize(@raw_input : String)
    @elves_count = 0
    @game_board = [] of Array(String|Character)
    @characters = [] of Character
    @ticks = 0
  end

  # Game lifecycle

  def setup(elves_power)
    @characters = [] of Character
    @ticks = 0
    @elves_count = 0
    @game_board = raw_input.split("\n").map_with_index do |r, y|
      r.strip.split("").map_with_index do |char, x|
        thing = case char
                when "G"
                  Goblin.new(x, y)
                when "E"
                  @elves_count = @elves_count + 1
                  Elf.new(x, y, elves_power)
                else
                  char
                end
        @characters.push(thing) if thing.is_a?(Character)
        thing
      end
    end
  end

  def run
    elves_power = 3
    loop do
      setup(elves_power)
      puts "Initial state, power of #{elves_power}"
      print_game_board
      until game_over? || elves.size != elves_count
        move_characters
        puts "Round #{ticks}"
        print_game_board
      end
      print_game_board
      break if elves_win?
      elves_power = elves_power + 1
    end
    {ticks, characters.sum { |c| c.hp }, elves_power}
  end

  private def elves_win?
    game_over? && elves.size == elves_count
  end

  private def game_over?
    goblins.empty? || elves.empty?
  end

  private def move_characters
    sorted_characters.each do |character|
      return if game_over?
      next if character.dead?

      path = [] of Point

      unless enemy_neighbors_of(character).any?
        possible_paths = [] of Array(Point)
        (character.is_a?(Goblin) ? elves : goblins).each do |other_character|
          character_paths = neighbors_of(Point.new(other_character.x, other_character.y)).compact_map do |other_char_neighbor|
            neighbor_thing = game_board[other_char_neighbor.y][other_char_neighbor.x]
            next nil if neighbor_thing.is_a?(Character) && neighbor_thing != character
            suggested_path = shortest_path_between(character.point, other_char_neighbor)
            suggested_path.any? ? suggested_path : nil
          end
          possible_paths.concat(character_paths) if character_paths.any?
        end

        if possible_paths.any?
          min_path_size = possible_paths.min_by { |p| p.size }.size
          min_paths = possible_paths.select { |p| p.size == min_path_size }
          path = min_paths.sort_by { |p| [p[p.size-1].y, p[p.size-1].x] }[0]
        end
      end

      if path.any?
        game_board[character.y][character.x] = "."
        character.x = path[0].x
        character.y = path[0].y
        game_board[character.y][character.x] = character
      end

      attack(character)
    end
    @ticks += 1
  end

  private def attack(character)
    weakest_enemy_point = enemy_neighbors_of(character).min_by? do |enemy|
      game_board[enemy.y][enemy.x].as(Character).hp
    end

    return unless weakest_enemy_point

    enemy = game_board[weakest_enemy_point.y][weakest_enemy_point.x].as(Character)
    enemy.hp -= character.attack_power
    kill_character(enemy) if enemy.dead?
  end

  # Pathfinding

  private def shortest_path_between(point1 : Point, point2 : Point) : Array(Point)
    _distances, previous_paths = dijkstra(point1)
    # Originally I tried to cache the path maps, but that doesn't work because as units
    # move the map changes (since you can't pass through other units), which makes
    # the cache invalid.
    construct_path(previous_paths, point2)
  end

  private def dijkstra(point : Point)
    nodes = Set(Point).new
    nodes.add(point)
    previous = [] of Array(Nil|Point)
    distances = game_board.map_with_index do |row, y|
      new_previous_row = [] of (Nil|Point)
      previous.push(new_previous_row)
      row.map_with_index do |thing, x|
        nodes.add(Point.new(x, y)) if game_board[y][x] == "."
        new_previous_row.push(nil)
        Int32::MAX
      end
    end

    distances[point.y][point.x] = 0

    while nodes.any?
      min_dist_node = nodes.min_by { |node| distances[node.y][node.x] }
      nodes.delete(min_dist_node)
      neighbors_of(min_dist_node).each do |neighbor|
        next if distances[min_dist_node.y][min_dist_node.x] == Int32::MAX
        alternate = distances[min_dist_node.y][min_dist_node.x] + 1
        if alternate < distances[neighbor.y][neighbor.x]
          distances[neighbor.y][neighbor.x] = alternate
          previous[neighbor.y][neighbor.x] = min_dist_node
        end
      end
    end

    {distances, previous}
  end

  private def construct_path(paths, point : (Point|Nil))
    path = [] of Point
    until point.nil?
      path.push(point)
      point = paths[point.y][point.x]
    end
    path = path.reverse
    path.shift
    path
  end

  private def neighbors_of(point : Point) : Array(Point)
    coords = [[point.x, point.y-1], [point.x-1, point.y], [point.x+1, point.y], [point.x, point.y+1]]
    neighbors = [] of Point

    coords.each do |coord|
      next if coord[0] < 0 || coord[1] < 0 || coord[1] >= game_board.size || coord[0] >= game_board[0].size
      thing = game_board[coord[1]][coord[0]]
      next if thing == "#"
      neighbors.push(Point.new(coord[0], coord[1]))
    end

    neighbors
  end

  private def enemy_neighbors_of(character) : Array(Point)
    neighbors_of(character.point).select do |neighbor_point|
      neighbor = game_board[neighbor_point.y][neighbor_point.x]
      neighbor.is_a?(Character) && (character.is_a?(Elf) && neighbor.is_a?(Goblin) || character.is_a?(Goblin) && neighbor.is_a?(Elf))
    end
  end

  # Helpers

  private def goblins
    characters.select { |c| c.is_a?(Goblin) }
  end

  private def elves
    characters.select { |c| c.is_a?(Elf) }
  end

  private def kill_character(character : Character)
    @characters = @characters.reject { |c| c == character }
    game_board[character.y][character.x] = "."
  end

  private def sorted_characters
    characters.sort_by { |c| [c.y, c.x] }
  end

  private def print_game_board
    puts "-----------------------"
    game_board.each do |row|
      row.each do |char|
        if char.is_a?(Goblin)
          print "G"
        elsif char.is_a?(Elf)
          print "E"
        else
          print char
        end
      end
      print "\n"
    end
    print "\n"

    # characters.each do |character|
    #   puts "Character at #{character.x}, #{character.y}: #{character.hp}"
    # end
    puts "-----------------------\n\n\n"
  end
end
