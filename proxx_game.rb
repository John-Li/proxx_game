require_relative 'proxx_game/proxx_game'

puts "Welcome to Proxx Game!"

# Validation loop
board = nil
while true
  print "Enter board dimentions (rows x columns, e.g. 10): "
  board_dimentions = gets.chomp.to_i
  print "Enter the number of Black holes: "
  num_holes = gets.chomp.to_i
  begin
    board = Board.new(board_dimentions, num_holes)
    break
  rescue Board::BoardArgumentError => e
    puts
    puts e.message
    puts
  end
end

game = ProxxGame.new(board)

# Gameplay loop
while true
  puts "Current state:"
  game.display_board
  print "Enter row and column (e.g. '3 4'): "
  input = gets.strip.split
  row, col = input[0].to_i, input[1].to_i

  game.move(row, col)
  break if game.won? || game.lost?
end
