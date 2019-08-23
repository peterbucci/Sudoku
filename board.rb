require 'Set'
require_relative "tile.rb"

class Board
  def self.from_file(puzzle)
    grid = Array.new
    puzzle.each { |line| grid << line.split("").map { |value| Tile.new(value) } }

    grid
  end

  def initialize(puzzle)
    @grid = Board.from_file(puzzle)
  end

  def render
    puts "\e[H\e[2J"
    puts "    " + @grid.map.with_index { |_, i| (i + 1) % 3 == 0 && i != 8 ? i.to_s + " |" : i.to_s }.join(" ")
    puts "    " + "-"*21
    
    @grid.each.with_index do |line, i| 
      create_line = i.to_s + " | "

      line.each.with_index do |tile, j| 
        create_line += tile.value

        (j + 1) % 3 == 0 && j != 8 ? create_line += " | " : create_line += " "
      end

      puts create_line
      puts "    " + "-"*21 if (i + 1) % 3 == 0 && i != 8
    end
  end

  def solved?
    [@grid, @grid.transpose, quadrants_to_rows(@grid)].all? { |grid| rows_solved?(grid) }
  end

  def rows_solved?(grid)
    grid.each do |line|
      value_set = Set.new
      line.each { |tile| value_set.add(tile.value) }
      return false if (1..9).map(&:to_s).any? { |num| !value_set.include?(num) }
    end

    true
  end

  def quadrants_to_rows(grid)
    result = Array.new(9) { Array.new }

    (0..8).each do |i|
      (0..8).each do |j|
        quadrant = (i / 3) * 3 + (j / 3)

        result[quadrant] << grid[i][j]
      end
    end

    result
  end

  def [](pos)
    row = pos[0]
    column = pos[1]
    @grid[row][column]
  end

  def []=(pos, value)
    row = pos[0]
    column = pos[1]
    @grid[row][column].value = value
  end
end

