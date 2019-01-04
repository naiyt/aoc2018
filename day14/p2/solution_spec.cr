require "spec"
require "./solution"

describe "Day 14 Problem 2" do
  it "works with the sample input" do
    recipe_count("51589").should eq(9)
    recipe_count("01245").should eq(5)
    recipe_count("92510").should eq(18)
    recipe_count("59414").should eq(2018)
  end

  it "works with my problem input" do
    recipe_count("580741").should eq(20330673)
  end
end
