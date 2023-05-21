require_relative 'proxx_game/logic'

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
