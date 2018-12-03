require "spec"
require "./solution"

describe "Day 3 Problem 1" do
  it "works with the sample input" do
    claims = [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2",
    ]

    # ........
    # ...2222.
    # ...2222.
    # .11XX22.
    # .11XX22.
    # .111133.
    # .111133.
    # ........

    overlapping_claims(claims).should eq(4)
  end

  it "errors out if the claims are formatted incorrectly" do
    claims = [
      "#1@ fdsfdsfds,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2",
    ]

    expect_raises(InvalidClaimsFormatError) do
      overlapping_claims(claims)
    end
  end

  it "generates the correct solution for my problem input" do
    claims = File.read("input.txt").split("\n")
    overlapping_claims(claims).should eq(115304)
  end
end
