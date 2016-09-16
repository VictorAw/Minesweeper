class Tile
  attr_accessor :adjacent_bombs

  def initialize(bomb, flagged, revealed=false)
    @bomb = bomb
    @flagged = flagged
    @revealed = revealed
    @adjacent_bombs = 0
  end

  def is_bomb
    @bomb = true
  end

  def is_bomb?
    @bomb
  end

  def is_flag?
    @flagged
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def reveal
    @revealed = true
  end

  def to_s
    if @revealed
      @bomb ? "X" : @adjacent_bombs == 0 ? "-" : @adjacent_bombs.to_s
    else
      "*"
    end
  end
end
