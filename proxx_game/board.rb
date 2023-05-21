require_relative 'cell'

class Board
  class BoardArgumentError < StandardError; end
  
  attr_reader :layout, :row_size, :col_size

  def initialize(board_dimentions=10, num_holes=10)
    validate_dimentions(board_dimentions)
    validate_num_holes(num_holes)
    @row_size = board_dimentions
    @col_size = board_dimentions
    @layout = Array.new(@row_size) { Array.new(@col_size) { Cell.new } }
    place_holes(num_holes)
    calculate_adjacent_holes
  end

  def cell(row, col)
    @layout[row][col]
  end

  def in_board_bounds?(row, col)
    row.between?(0, row_size - 1) && col.between?(0, col_size - 1)
  end

  def reveal_cells(row, col)
    return if !in_board_bounds?(row, col) || cell(row, col).revealed?

    cell(row, col).reveal

    if cell(row, col).adjacent_holes == 0
      [-1, 0, 1].each do |row_diff|
        [-1, 0, 1].each do |col_diff|
          reveal_cells(row + row_diff, col + col_diff) unless row_diff == 0 && col_diff == 0
        end
      end
    end
  end

  def reveal_all
    layout.each do |row|
      row.each do |cell|
        cell.reveal
      end
    end
  end

  private

  def validate_dimentions(dimentions)
    unless dimentions.is_a?(Numeric) && dimentions.between?(2, 40)
      raise BoardArgumentError, "Board dimentions must be a number between 2 and 40"
    end
  end

  def validate_num_holes(num_holes)
    unless num_holes.is_a?(Numeric)
      raise BoardArgumentError, "Number of Black holes must be a number ;)"
    end
  end

  def place_holes(num_holes)
    positions = (0...row_size).to_a.product((0...col_size).to_a)
    positions.sample(num_holes).each do |row, col|
      cell(row, col).to_hole
    end
  end

  def calculate_adjacent_holes
    layout.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        next unless cell.hole?
        [-1, 0, 1].each do |row_diff|
          [-1, 0, 1].each do |col_diff|
            next if row_diff == 0 && col_diff == 0
            adj_row, adj_col = row_idx + row_diff, col_idx + col_diff
            if in_board_bounds?(adj_row, adj_col)
              cell(adj_row, adj_col).adjacent_holes += 1
            end
          end
        end
      end
    end
  end
end
