require_relative "tile"
require "byebug"
require 'colorize'

class Minesweeper

  def initialize(rows, cols, bomb_count)
    @row_count = rows
    @col_count = cols
    @bomb_count = bomb_count
    @grid = empty_grid(rows, cols)
    populate_grid
    @running = false
  end

  def draw_grid
    @grid.each do |el|
        p el.join " | "
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []= (pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def populate_grid
    bombs_placed = {}
    until bombs_placed.size == @bomb_count
      pos = [Random.rand(0...@row_count), Random.rand(0...@col_count)]
      bombs_placed[pos] = true
    end

    bombs_placed.keys.each do |pos|
      self[pos].is_bomb
    end
  end

  def empty_grid(rows, cols)
    result = Array.new(rows) do
      Array.new(cols) { Tile.new(false, false) }
    end
    result
  end

  def reveal(pos, origin, selected)
    if self[pos].is_bomb? && selected
      game_over
      return
    end
    return 1 if self[pos].is_bomb? && !selected
    # debugger
    i, j = pos
    return 0 if i < 0 || i >= @row_count
    return 0 if j < 0 || j >= @col_count
    bomb_count = 0

    neighbors = [[i-1, j-1], [i-1, j], [i-1, j+1],
                 [i, j-1], [i, j+1],
                 [i+1, j-1], [i+1, j], [i+1, j+1]]

    neighbors.each do |neighbor|
      unless neighbor == origin
        bomb_count += reveal(neighbor, pos, false)
      end
    end

    self[pos].adjacent_bombs = bomb_count
    self[pos].reveal
    0
  end

  def game_over
    @running = false
  end
end

m = Minesweeper.new(3, 3, 6)
m.draw_grid
m.reveal([0, 0], nil, true)
m.draw_grid
