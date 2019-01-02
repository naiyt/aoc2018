require "spec"
require "./solution"

describe "Day 13 Problem 1" do
  it "works with the sample input" do
    input = "/->-\\        
|   |  /----\\
| /-+--+-\\  |
| | |  | v  |
\\-+-/  \\-+--/
  \\------/     
"

    first_crash(input).should eq({7,3})
  end

  it "generates the correct solution for my problem input" do
    first_crash(File.read("input.txt")).should eq({82,104})
  end
end
