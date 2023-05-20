class Cell
  attr_accessor :hole, :adjacent_holes

  def initialize(hole=false)
    @hole = hole
    @revealed = false
    @adjacent_holes = 0
  end

  def reveal
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def hole?
    @hole
  end
end

class ProxxGame
  attr_reader :board, :row_size, :col_size

  def initialize(board_dimentions=10, num_holes=10)
    @row_size = board_dimentions
    @col_size = board_dimentions
    @board = Array.new(@row_size) { Array.new(@col_size) { Cell.new } }
    place_holes(num_holes)
    calculate_adjacent_holes
  end

  def display_column_numbers
    print '+ '
    (0...col_size).each { |col| print "#{col} " }
    puts
  end

  def display_row_number(row_index)
    print "#{row_index} "
  end

  def display_board
    puts
    display_column_numbers
    @board.each_with_index do |row, index|
      display_row_number(index)
      row.each do |cell|
        if cell.revealed?
          print cell.hole? ? "H " : "#{cell.adjacent_holes} "
        else
          print "_ "
        end
      end
      puts
    end
    puts
  end

  def reveal_all
    @board.each do |row|
      row.each do |cell|
        cell.reveal
      end
    end
    display_board
  end

  def move(row, col)
    if !in_board_bounds?(row, col)
      puts "Invalid move. Please enter valid row and column."
      return true
    end

    return if @board[row][col].revealed?

    reveal_cells(row, col)

    if @board[row][col].hole?
      puts "Game Over! You've revealed a black hole!"
      reveal_all
      return false
    elsif won?
      puts 'Congratulations! You won!'
      reveal_all
      return false
    else
      return true
    end
  end

  def reveal_cells(row, col)
    return if !in_board_bounds?(row, col) || board[row][col].revealed?

    board[row][col].reveal

    if board[row][col].adjacent_holes == 0
      [-1, 0, 1].each do |row_diff|
        [-1, 0, 1].each do |col_diff|
          reveal_cells(row + row_diff, col + col_diff) unless row_diff == 0 && col_diff == 0
        end
      end
    end
  end

  def in_board_bounds?(row, col)
    row.between?(0, row_size - 1) && col.between?(0, col_size - 1)
  end

  def place_holes(num_holes)
    # generate all possible possitions
    positions = (0...row_size).to_a.product((0...col_size).to_a)
    # take num_holes random positions
    positions.sample(num_holes).each do |row, col|
      board[row][col].hole = true
    end
  end

  def calculate_adjacent_holes
    board.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        next unless cell.hole?

        [-1, 0, 1].each do |row_diff|
          [-1, 0, 1].each do |col_diff|
            next if row_diff == 0 && col_diff == 0

            adj_row, adj_col = row_idx + row_diff, col_idx + col_diff
            if in_board_bounds?(adj_row, adj_col)
              board[adj_row][adj_col].adjacent_holes += 1
            end
          end
        end
      end
    end
  end

  def won?
    @board.each do |row|
      row.each do |cell|
        if !cell.hole? && !cell.revealed?
          return false
        end
      end
    end
    true
  end
end

puts "Welcome to Proxx Game!"
print "Enter board dimentions (rows x columns, e.g. 10): "
board_dimentions = gets.chomp.to_i
print "Enter the number of Black holes: "
num_holes = gets.chomp.to_i

# Gameplay loop
game = ProxxGame.new(board_dimentions, num_holes)

while true
  puts "Current state:"
  game.display_board
  print "Enter row and column (e.g. '3 4'): "
  input = gets.strip.split
  row, col = input[0].to_i, input[1].to_i

  result = game.move(row, col)
  if result == false
    break
  end
end
