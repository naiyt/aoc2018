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

class Graph
  def initialize(@head_nodes : Array(Node), @workers : Int32, @base_work_cost : Int32, @node_count : Int32)
    @completed_values = Set(Char).new
    @tick = 0
    @working = {} of Node => Int32
  end

  def work
    until completed?
      @working.each do |node, node_cost|
        if node_cost <= @tick
          @completed_values.add(node.value)
          @head_nodes += node.next_nodes.select { |node| pre_reqs_completed(node) }
          @working.delete(node)
        end
      end

      (@workers - @working.size).times do
        next unless next_node = pop
        @working[next_node] = @tick + cost(next_node.value)
      end

      @tick += 1 unless completed?
    end

    @tick
  end

  private def pop
    ready_node = @head_nodes.each_with_index.find { |node, i| pre_reqs_completed(node) }
    return nil unless ready_node
    @head_nodes.delete_at(ready_node[1])
    ready_node[0]
  end

  private def cost(char : Char)
    char.ord - 64 + @base_work_cost
  end

  private def pre_reqs_completed(node : Node)
    node.pre_reqs.all? { |val| @completed_values.includes?(val) }
  end

  private def completed?
    @completed_values.size >= @node_count
  end
end

def sum_of_its_parts(steps : Array(String), workers : Int32, base_work_cost : Int32)
  nodes = {} of Char => Node

  steps.each do |step|
    node_val = step[5]
    next_val = step[36]
    nodes[node_val] ||= Node.new(node_val)
    nodes[next_val] ||=Node.new(next_val)
    nodes[node_val].push_node(nodes[next_val])
  end

  head_nodes = nodes.values.select { |node| node.pre_reqs.size == 0 }
  graph = Graph.new(head_nodes, workers, base_work_cost, nodes.size)
  graph.work
end
