class Star
  getter x, y, velocity_x, velocity_y

  def initialize(@x : Int32, @y : Int32, @velocity_x : Int32, @velocity_y : Int32)
  end

  def move
    @x += @velocity_x
    @y += @velocity_y
  end
end

def draw_star_map(stars : Array(Star))
  max_x = stars.max_by { |star| star.x }.x
  min_x = stars.min_by { |star| star.x }.x
  max_y = stars.max_by { |star| star.y }.y
  min_y = stars.min_by { |star| star.y }.y

  str = String.build do |io|
    (min_y..max_y).each do |y|
      (min_x..max_x).each do |x|
        # This is slow, but max_x and max_y should be small at this point
        if stars.any? { |star| star.x == x && star.y == y }
          io << "#"
        else
          io << "."
        end
      end
      io << "\n"
    end
  end

  puts str
end

def possible_message?(stars : Array(Star), x_similarity : Int32, y_similarity : Int32)
  stars.group_by { |star| star.x }.values.max_by { |arr| arr.size }.size >= x_similarity &&
    stars.group_by { |star| star.y }.values.max_by { |arr| arr.size }.size >= y_similarity
end

def align_stars(stars : Array(Star), x_similarity : Int32, y_similarity : Int32)
  iterations = 0

  puts "Searching for a message..."

  loop do
    if possible_message?(stars, x_similarity, y_similarity)
      draw_star_map(stars)
      print "Is this your message (#{iterations} seconds have passed)? (y/n) "
      response = gets.not_nil!
      break if ["y", "yes"].includes?(response.downcase)
      puts "\n\n"
    end
    stars.each { |star| star.move }
    iterations += 1
  end
end

input_file = ARGV[0]
x_similarity = ARGV[1].to_i
y_similarity = ARGV[2].to_i
raw_input = File.read(input_file).split("\n")
stars = raw_input.map do |row|
  position = row.match(/position=<\s*(-?\d+),\s*(-?\d+)>/)
  velocity = row.match(/velocity=<\s*(-?\d+),\s*(-?\d+)>/)
  raise "Invalid row: #{row}" unless position && velocity
  Star.new(position[1].to_i, position[2].to_i, velocity[1].to_i, velocity[2].to_i)
end

align_stars(stars, x_similarity, y_similarity)
