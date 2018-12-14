require "spec"
require "./solution"

describe "Day 9 Problem 1" do
  it "works with the sample input" do
    marble_high_score("9 players; last marble is worth 25 points").should eq(32)
    marble_high_score("10 players; last marble is worth 1618 points").should eq(8317)
    marble_high_score("13 players; last marble is worth 7999 points").should eq(146373)
    marble_high_score("17 players; last marble is worth 1104 points").should eq(2764)
    marble_high_score("21 players; last marble is worth 6111 points").should eq(54718)
    marble_high_score("30 players; last marble is worth 5807 points").should eq(37305)
  end

  it "generates the correct solution for my problem input" do
    marble_high_score(File.read("input.txt")).should eq(412117)
  end
end
