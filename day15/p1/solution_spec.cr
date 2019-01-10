require "spec"
require "./solution"

describe "Day 15 Problem 1" do
  it "works with sample input 1" do
    input = <<-HERE
      #######
      #.G...#
      #...EG#
      #.#.#G#
      #..G#E#
      #.....#
      #######
    HERE

    Game.new(input).run.should eq({47, 590})
  end

  it "works with sample input 2" do
    input = <<-HERE
      #######
      #G..#E#
      #E#E.E#
      #G.##.#
      #...#E#
      #...E.#
      #######
    HERE

    Game.new(input).run.should eq({37, 982})
  end

  it "works with sample input 3" do
    input = <<-HERE
      #######
      #E..EG#
      #.#G.E#
      #E.##E#
      #G..#.#
      #..E#.#
      #######
    HERE

    Game.new(input).run.should eq({46, 859})
  end


  it "works with sample input 4" do
    input = <<-HERE
      #######
      #E.G#.#
      #.#G..#
      #G.#.G#  -->  #..#..#
      #G..#.#
      #...E.#
      #######
    HERE

    Game.new(input).run.should eq({35, 793})
  end

  it "works with sample input 5" do
    input = <<-HERE
      #######
      #.E...#
      #.#..G#
      #.###.#
      #E#G#G#
      #...#G#
      #######
    HERE

    Game.new(input).run.should eq({54, 536})
  end

  it "works with sample input 6" do
    input = <<-HERE
      #########
      #G......#
      #.E.#...#
      #..##..G#
      #...##..#
      #...#...#
      #.G...G.#
      #.....G.#
      #########
    HERE

    Game.new(input).run.should eq({20, 937})
  end

  it "works with my problem input" do
    Game.new(File.read("input.txt")).run.should eq({65, 2820})
  end
end
