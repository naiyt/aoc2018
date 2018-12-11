class Node
  property value : Char
  property next_nodes : Array(Node)
  property pre_reqs : Set(Char)

  def initialize(@value : Char)
    @next_nodes = [] of Node
    @pre_reqs = Set(Char).new
  end

  def push_node(node : Node)
    node.pre_reqs.add(@value)
    @next_nodes.push(node)
  end
end

# Keeps track of our current head nodes and all nodes that have already been popped.
# When you pop a new node, the Graph will find the alphabetically first head node,
# and then add any of its next_nodes that have had all pre_reqs fulfilled to head_nodes.
class Graph
  property head_nodes : Array(Node)
  getter popped_values : Set(Char)

  def initialize(@head_nodes : Array(Node))
    @popped_values = Set(Char).new
  end

  def pop_head
    @head_nodes = @head_nodes.sort_by { |node| node.value }.reverse
    popped_head = @head_nodes.pop
    popped_values.add(popped_head.value)
    @head_nodes += popped_head.next_nodes.select { |node| node.pre_reqs.all? { |val| popped_values.includes?(val) } }
    popped_head.value
  end
end

def sum_of_its_parts(steps : Array(String))
  nodes = {} of Char => Node

  steps.each do |step|
    node_val = step[5]
    next_val = step[36]
    nodes[node_val] ||= Node.new(node_val)
    nodes[next_val] ||=Node.new(next_val)
    nodes[node_val].push_node(nodes[next_val])
  end

  head_nodes = nodes.values.select { |node| node.pre_reqs.size == 0 }
  graph = Graph.new(head_nodes)
  answer = [] of Char
  while graph.head_nodes.size > 0
    answer.push(graph.pop_head)
  end
  answer.join
end
