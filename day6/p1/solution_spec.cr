require "spec"
require "./solution"

describe "Day 5 Problem 1" do
  it "works with the sample input" do
    input = [
      [1, 1],
      [1, 6],
      [8, 3],
      [3, 4],
      [5, 5],
      [8, 9],
    ]
    chronal_coordinates(input).should eq(17)
  end

  it "generates the correct solution for my problem input" do
    input = File.read("input.txt").split("\n").map { |row| row.split(", ").map { |i| i.to_i } }
    chronal_coordinates(input).should eq(4011)
  end
end
