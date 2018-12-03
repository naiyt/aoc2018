class InvalidClaimsFormatError < Exception
end

class Claim
  getter id : Int32
  getter x : Int32
  getter y : Int32
  getter width : Int32
  getter height : Int32

  def initialize(@claim : String)
    @id, @x, @y, @width, @height = parse!
  end

  private def parse!
    match_coords = @claim.match(/\d+,\d+/)
    x, y = match_coords ? match_coords[0].split(",").map { |i| i.to_i } : [nil, nil]
    match_dimensions = @claim.match(/\d+x\d+/)
    width, height = match_dimensions ? match_dimensions[0].split("x").map { |i| i.to_i } : [nil, nil]
    match_id = @claim.match(/#\d+/)
    id = match_id ? match_id[0].split("#")[1].to_i : nil

    unless x && y && width && height && id
      raise InvalidClaimsFormatError.new("Claims must be in this format: #1 @ 1,3: 4x4, got #{@claim}")
    else
      [id, x, y, width, height]
    end
  end
end

def intact_claim(claims : Array(String))
  # Fabric is at least 1000 x 1000 - may have to dynamically allocate more if it's bigger
  fabric = [] of Array(Int32)
  1000.times do
    row = [] of Int32
    1000.times { row.push(0) }
    fabric.push(row)
  end

  parsed_claims = claims.map { |claim| Claim.new(claim) }

  parsed_claims.each do |claim|
    (claim.x...claim.x+claim.width).each do |i|
      (claim.y...claim.y+claim.height).each do |j|
        fabric[i][j] += 1
      end
    end
  end

  intact = parsed_claims.find do |claim|
    (claim.x...claim.x+claim.width).all? do |i|
      (claim.y...claim.y+claim.height).all? do |j|
        fabric[i][j] == 1
      end
    end
  end

  intact ? intact.id : nil
end
