require "spec"
require "./solution"

describe "Day 12 Problem 1" do
  it "generates the correct solution for my problem input" do
    game_of_pots(File.read("input.txt")).should eq(2600000000919)
  end
end
