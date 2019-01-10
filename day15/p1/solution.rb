require "set"
require "pry"
require "pry-nav"

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Character
  attr_accessor :hp, :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @hp = 200
  end

  def point
    Point.new(x, y)
  end

  def dead?
    hp <= 0
  end

  def attack_power
    3
  end
end

class Goblin < Character
end

class Elf < Character
end

class Game
  attr_accessor :game_board
  attr_accessor :characters

  def initialize(raw_input)
    @characters = []
    @game_board = raw_input.split("\n").each_with_index.map do |r, y|
      r.strip.split("").each_with_index.map do |char, x|
        thing = case char
                when "G"
                  Goblin.new(x, y)
                when "E"
                  Elf.new(x, y)
                else
                  char
                end
        @characters.push(thing) if thing.is_a?(Character)
        thing
      end
    end
  end

  # Game lifecycle

  def run
    @ticks = 0
    print_game_board
    until game_over?
      move_characters
      puts "Round #{@ticks}"
      print_game_board
    end
    [@ticks, characters.sum { |c| c.hp }]
  end

  def game_over?
    goblins.empty? || elves.empty?
  end

  def move_characters
    sorted_characters.each do |character|
      return if game_over?
      next if character.dead?
      path = []
      lowest_movement = 10000000
      unless enemy_neighbors_of(character).any?
        (character.is_a?(Goblin) ? elves : goblins).each do |other_character|
          possible_paths = neighbors_of(Point.new(other_character.x, other_character.y)).map do |other_char_neighbor|
            neighbor_thing = game_board[other_char_neighbor.y][other_char_neighbor.x]
            next nil if neighbor_thing.is_a?(Character) && neighbor_thing != character
            suggested_path = shortest_path_between(character.point, other_char_neighbor)
            suggested_path.any? ? suggested_path : nil
          end.compact
          next unless possible_paths.any?
          min_path_size = possible_paths.min_by { |p| p.size }.size
          min_paths = possible_paths.select { |p| p.size == min_path_size }
          min_paths = min_paths.sort_by { |p| [p[p.size-1].y, p[p.size-1].x] }
          first_min_path = min_paths[0]

          if first_min_path.size < lowest_movement && first_min_path.any?
            path = first_min_path
            lowest_movement = first_min_path.size
          end
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

  def attack(character)
    weakest_enemy_point = enemy_neighbors_of(character).min_by do |enemy|
      game_board[enemy.y][enemy.x].hp
    end

    return unless weakest_enemy_point

    enemy = game_board[weakest_enemy_point.y][weakest_enemy_point.x]
    enemy.hp -= character.attack_power
    kill_character(enemy) if enemy.dead?
  end

  # Pathfinding

  def shortest_path_between(point1, point2)
    _distances, previous_paths = dijkstra(point1)
    # Originally I tried to cache the path maps, but that doesn't work because as units
    # move the map changes (since you can't pass through other units), which makes
    # the cache invalid.
    construct_path(previous_paths, point2)
  end

  def dijkstra(point)
    nodes = Set.new
    nodes.add(point)
    previous = []
    distances = game_board.each_with_index.map do |row, y|
      new_previous_row = []
      previous.push(new_previous_row)
      row.each_with_index.map do |thing, x|
        nodes.add(Point.new(x, y)) if game_board[y][x] == "."
        new_previous_row.push(nil)
        10000000
      end
    end

    distances[point.y][point.x] = 0

    while nodes.any?
      min_dist_node = nodes.min_by { |node| distances[node.y][node.x] }
      nodes.delete(min_dist_node)
      neighbors_of(min_dist_node).each do |neighbor|
        alternate = distances[min_dist_node.y][min_dist_node.x] + 1
        if alternate < distances[neighbor.y][neighbor.x]
          distances[neighbor.y][neighbor.x] = alternate
          previous[neighbor.y][neighbor.x] = min_dist_node
        end
      end
    end

    [distances, previous]
  end

  def construct_path(paths, point)
    path = []
    until point.nil?
      path.push(point)
      point = paths[point.y][point.x]
    end
    path = path.reverse
    path.shift
    path
  end

  def neighbors_of(point)
    coords = [[point.x, point.y-1], [point.x-1, point.y], [point.x+1, point.y], [point.x, point.y+1]]
    neighbors = []

    coords.each do |coord|
      next if coord[0] < 0 || coord[1] < 0 || coord[1] >= game_board.size || coord[0] >= game_board[0].size
      thing = game_board[coord[1]][coord[0]]
      next if thing == "#"
      neighbors.push(Point.new(coord[0], coord[1]))
    end

    neighbors
  end

  def enemy_neighbors_of(character)
    neighbors_of(character.point).select do |neighbor_point|
      neighbor = game_board[neighbor_point.y][neighbor_point.x]
      neighbor.is_a?(Character) && (character.is_a?(Elf) && neighbor.is_a?(Goblin) || character.is_a?(Goblin) && neighbor.is_a?(Elf))
    end
  end

  # Helpers

  def goblins
    characters.select { |c| c.is_a?(Goblin) }
  end

  def elves
    characters.select { |c| c.is_a?(Elf) }
  end

  def kill_character(character)
    @characters = @characters.reject { |c| c == character }
    game_board[character.y][character.x] = "."
  end

  def sorted_characters
    characters.sort_by { |c| [c.y, c.x] }
  end

  def print_game_board
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

    characters.each do |character|
      puts "Character at #{character.x}, #{character.y}: #{character.hp}"
    end
    puts "-----------------------\n\n\n"
  end
end

input = <<-HERE
  #######
  #G..#E#
  #E#E.E#
  #G.##.#
  #...#E#
  #...E.#
  #######
HERE

pp Game.new(File.read("input.txt")).run
