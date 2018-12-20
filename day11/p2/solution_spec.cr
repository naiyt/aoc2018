require "spec"
require "./solution"

describe "Day 11 Problem 1" do
  it "works with sample input 1" do
    ChronalCharge.new(18).solve.should eq({90,269,16})
  end

  it "works with sample input 2" do
    ChronalCharge.new(42).solve.should eq({232,251,12})
  end

  it "generates the correct solution for my problem input" do
    ChronalCharge.new(File.read("input.txt").to_i).solve.should eq({231, 107, 14})
  end
end
