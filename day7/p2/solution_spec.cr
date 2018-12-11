require "spec"
require "./solution"

describe "Day 7 Problem 1" do
  it "works with the sample input" do
    steps = [
      "Step C must be finished before step A can begin.",
      "Step C must be finished before step F can begin.",
      "Step A must be finished before step B can begin.",
      "Step A must be finished before step D can begin.",
      "Step B must be finished before step E can begin.",
      "Step D must be finished before step E can begin.",
      "Step F must be finished before step E can begin.",
    ]

    sum_of_its_parts(steps, 2, 0).should eq(15)
  end

  it "generates the correct solution for my problem input" do
    steps = File.read("input.txt").split("\n")
    sum_of_its_parts(steps, 5, 60).should eq(1050)
  end
end
