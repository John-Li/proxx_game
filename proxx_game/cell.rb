class Cell
  attr_accessor :hole, :adjacent_holes

  def initialize
    @hole = false
    @revealed = false
    @adjacent_holes = 0
  end

  def reveal
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def to_hole
    @hole = true
  end

  def hole?
    @hole
  end
end
