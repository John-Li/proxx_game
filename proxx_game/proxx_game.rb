require_relative 'board'

class ProxxGame
  module State
    PLAYING = :playing
    WIN = :win
    LOST = :lost
  end

  attr_reader :board

  def initialize(board)
    @board = board
    @state = State::PLAYING
  end

  def display_column_numbers
    print align('+')
    (0...board.col_size).each { |col| print align_s(col) }
    puts
  end

  def display_row_number(row_index)
    print align(row_index)
  end

  def display_board
    puts
    display_column_numbers
    board.layout.each_with_index do |row, index|
      display_row_number(index)
      row.each do |cell|
        if cell.revealed?
          print cell.hole? ? align_s('H') : align_s(cell.adjacent_holes)
        else
          print align_s('_')
        end
      end
      puts
    end
    puts
  end

  def reveal_all
    board.reveal_all
    display_board
  end

  def move(row, col)
    if !board.in_board_bounds?(row, col)
      puts
      puts "Invalid move. Please enter valid row and column."
      puts
      return
    end

    return if board.cell(row, col).revealed?

    board.reveal_cells(row, col)

    if board.cell(row, col).hole?
      puts "Game Over! You've revealed a black hole!"
      reveal_all
      @state = State::LOST
    elsif won?
      puts 'Congratulations! You won!'
      reveal_all
      @state = State::WIN
    else
      @state = State::PLAYING
    end
  end

  def lost?
    @state == State::LOST
  end

  def won?
    return true if @state == State::WIN
    board.layout.each do |row|
      row.each do |cell|
        if !cell.hole? && !cell.revealed?
          return false
        end
      end
    end
    true
  end

  private

  def align(data)
    data.to_s.rjust(2, ' ')
  end

  def align_s(data)
    align(data) + ' '
  end
end
