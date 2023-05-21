describe Board do
  let(:board) { Board.new }

  describe '#initialize' do
    context 'when invalid dimentions' do
      it 'raises an exception' do
        expect { Board.new(0) }.to raise_error(Board::BoardArgumentError, 'Board dimentions must be a number between 2 and 40')
      end
    end

    context 'when invalid number of holes' do
      it 'raises an exception' do
        expect { Board.new(10, "a") }.to raise_error(Board::BoardArgumentError, 'Number of Black holes must be a number ;)')
      end
    end
  end

  describe '#cell' do
    it 'returns the cell at specified row and column' do
      expect(board.cell(0,0)).to be_instance_of(Cell)
    end
  end

  describe '#in_board_bounds?' do
    it 'returns true if the row and column are within bounds' do
      expect(board.in_board_bounds?(0, 0)).to be true
    end

    it 'returns false if the row and column are out of bounds' do
      expect(board.in_board_bounds?(-1, -1)).to be false
    end
  end

  describe '#reveal_cells' do
    context 'when cell is not revealed and within bounds' do
      it 'reveals the cell' do
        board.reveal_cells(0, 0)
        expect(board.cell(0,0).revealed?).to be true
      end
    end
  end

  describe '#reveal_all' do
    it 'reveals all cells' do
      board.reveal_all
      board.layout.flatten.each do |cell|
        expect(cell.revealed?).to be true
      end
    end
  end
end
