require "spec"
require "./solution"

describe "Day 8 Problem 1" do
  it "works with the sample input" do
    input = [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]
    memory(input).should eq(66)
  end

  it "generates the correct solution for my problem input" do
    input = File.read("input.txt").split(" ").map { |i| i.to_i }
    memory(input).should eq(22989)
  end
end
