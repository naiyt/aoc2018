require "spec"
require "./solution"

describe "Day 9 Problem 2" do
  it "generates the correct solution for my problem input" do
    marble_high_score(File.read("input.txt"), 100).should eq(3444129546_i64)
  end
end
