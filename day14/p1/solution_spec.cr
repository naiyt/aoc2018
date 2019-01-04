require "spec"
require "./solution"

describe "Day 14 Problem 1" do
  it "works with the sample input" do
    recipes(9).should eq("5158916779")
    recipes(5).should eq("0124515891")
    recipes(18).should eq("9251071085")
    recipes(2018).should eq("5941429882")
  end

  it "works with my problem input" do
    recipes(580741).should eq("6910849249")
  end
end
