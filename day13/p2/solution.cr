class Cart
  property heading, x, y
  INTERSECTIONS = ["LEFT", "STRAIGHT", "RIGHT"]

  def initialize(@heading : Char, @x : Int32, @y : Int32)
    @next_intersection = 0
  end

  def move(track : Char)
    case track
    when '\\', '/'
      turn_corner(track)
    when '+'
      handle_intersection
    end

    move_straight
  end

  private def move_straight
    case heading
    when 'v'
      @y += 1
    when '^'
      @y -= 1
    when '>'
      @x += 1
    when '<'
      @x -= 1
    end
  end

  private def turn_left
    case heading
    when 'v'
      @heading = '>'
    when '^'
      @heading = '<'
    when '>'
      @heading = '^'
    when '<'
      @heading = 'v'
    end
  end

  private def turn_right
    case heading
    when 'v'
      @heading = '<'
    when '^'
      @heading = '>'
    when '>'
      @heading = 'v'
    when '<'
      @heading = '^'
    end
  end

  private def turn_corner(track : Char)
    case heading
    when 'v', '^'
      turn_right if track == '/'
      turn_left if track == '\\'
    when '>', '<'
      turn_left if track == '/'
      turn_right if track == '\\'
    end
  end

  private def handle_intersection
    intersection = INTERSECTIONS[@next_intersection % INTERSECTIONS.size]

    case intersection
    when "LEFT"
      turn_left
    when "RIGHT"
      turn_right
    end

    @next_intersection += 1
  end
end

def final_cart(input : String)
  map = input.split("\n").map { |row| row.chars }
  carts = {} of {Int32, Int32} => Cart
  map.each_with_index do |row, y|
    row.each_with_index do |char, x|
      next unless ['>', '^', 'v', '<'].includes?(char)
      carts[{x, y}] = Cart.new(char, x, y)
      map[y][x] = ['>', '<'].includes?(char) ? '-' : '|'
    end
  end

  loop do
    new_carts = {} of {Int32, Int32} => Cart
    map.each_with_index do |row, y|
      row.each_with_index do |char, x|
        next unless carts.has_key?({x, y})
        cart = carts.delete({x, y}).as(Cart)
        cart.move(char)
        if carts.has_key?({cart.x, cart.y}) || new_carts.has_key?({cart.x, cart.y})
          new_carts.delete({cart.x, cart.y})
          carts.delete({cart.x, cart.y})
        else
          new_carts[{cart.x, cart.y}] = cart
        end
      end
    end
    carts = new_carts
    return {carts.first[1].x, carts.first[1].y} if carts.size == 1
  end
end
