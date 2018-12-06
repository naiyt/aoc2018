require "spec"
require "./solution"

describe "Day 5 Problem 1" do
  it "works with the sample input" do
    shortest_possible_polymer("dabAcCaCBAcCcaDA").should eq(4)
  end

  it "generates the correct solution for my problem input" do
    shortest_possible_polymer(File.read("input.txt")).should eq(6872)
  end
end
