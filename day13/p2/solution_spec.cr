require "spec"
require "./solution"

describe "Day 13 Problem 2" do
  it "works with the sample input" do
    final_cart(File.read("test_input.txt")).should eq({6,4})
  end

  it "generates the correct solution for my problem input" do
    final_cart(File.read("input.txt")).should eq({82,104})
  end
end
