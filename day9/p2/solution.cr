class Node
  getter value : Int32
  property next_node : (Node|Nil)
  property previous_node : (Node|Nil)

  def initialize(@value : Int32)
    @next_node = nil
    @previous_node = nil
  end

  def push(val : Int32)
    node = Node.new(val)
    current_next = @next_node
    @next_node = node
    node.previous_node = self
    node.next_node = current_next
    current_next.previous_node = node unless current_next.nil?
    node
  end

  def delete
    if (next_node = @next_node) && (previous_node = @previous_node)
      previous_node.next_node = next_node
      next_node.previous_node = previous_node
    end

    {@value, next_node.as(Node)}
  end
end

class LinkedList
  getter head : (Node|Nil)

  def set_head(val : Int32)
    new_head = Node.new(val)
    new_head.next_node = new_head
    new_head.previous_node = new_head
    @head = new_head
    new_head
  end

  def relative_node(relative_pos : Int32, node : Node)
    if relative_pos < 0
      relative_pos.abs.times { node = node.previous_node.as(Node) }
    else
      relative_pos.times { node = node.next_node.as(Node) }
    end
    node
  end

  def insert_relative(relative_pos : Int32, node : Node, val : Int32)
    relative_node(relative_pos, node).push(val)
  end

  def delete_relative(relative_pos : Int32, node : Node)
    relative_node(relative_pos, node).delete
  end
end

def marble_high_score(game_rules, multiplier)
  match = game_rules.match(/(\d+) players; last marble is worth (\d+) points/)
  raise "Invalid input string" unless match
  num_players = match[1].to_i
  num_marbles = match[2].to_i * multiplier
  players = Array.new(num_players, 0.to_i64)
  game_board = LinkedList.new
  current_marble_value = 0
  current_marble_node : (Node|Nil) = nil

  while current_marble_value < num_marbles
    players.each_with_index do |_p, index|
      if current_marble_node && current_marble_value != 0 && current_marble_value % 23 == 0
        players[index] += current_marble_value
        deleted_val, current_marble_node = game_board.delete_relative(-7, current_marble_node)
        players[index] += deleted_val
      else
        if current_marble_node.nil?
          current_marble_node = game_board.set_head(current_marble_value)
        else
          current_marble_node = game_board.insert_relative(1, current_marble_node, current_marble_value)
        end
      end

      current_marble_value += 1
      break if current_marble_value > num_marbles
    end
  end

  players.max
end
