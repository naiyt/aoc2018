require "spec"
require "./solution"

describe "Day 11 Problem 1" do
  it "works with the sample input" do
    chronal_charge(42).should eq({21, 61})
  end

  it "generates the correct solution for my problem input" do
    chronal_charge(File.read("input.txt").to_i).should eq({233, 36})
  end
end
