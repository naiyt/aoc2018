class InvalidClaimsFormatError < Exception
end

class Claim
  getter x : Int32
  getter y : Int32
  getter width : Int32
  getter height : Int32

  def initialize(@claim : String)
    @x, @y, @width, @height = parse!
  end

  private def parse!
    match_coords = @claim.match(/\d+,\d+/)
    x, y = match_coords ? match_coords[0].split(",").map { |i| i.to_i } : [nil, nil]
    match_dimensions = @claim.match(/\d+x\d+/)
    width, height = match_dimensions ? match_dimensions[0].split("x").map { |i| i.to_i } : [nil, nil]

    unless x && y && width && height
      raise InvalidClaimsFormatError.new("Claims must be in this format: #1 @ 1,3: 4x4, got #{@claim}")
    else
      [x, y, width, height]
    end
  end
end

def overlapping_claims(claims : Array(String))
  # Fabric is at least 1000 x 1000 - may have to dynamically allocate more if it's bigger
  fabric = [] of Array(Int32)
  1000.times do
    row = [] of Int32
    1000.times { row.push(0) }
    fabric.push(row)
  end

  claims.each do |claim|
    claim = Claim.new(claim)
    (claim.x...claim.x+claim.width).each do |i|
      (claim.y...claim.y+claim.height).each do |j|
        fabric[i][j] += 1
      end
    end
  end

  fabric.sum { |row| row.count { |i| i > 1 } }
end
