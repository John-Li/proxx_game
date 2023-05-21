describe ProxxGame do
  let(:board) { Board.new(2, 2) }
  let(:game) { ProxxGame.new(board) }

  describe '#initialize' do
    it 'sets up a new game' do
      expect(game.board).to eq(board)
    end
  end

  describe '#move' do
    context 'when the move reveals a hole' do
      # fill whole board with holes
      # so any move leads to loosing
      let(:board) { Board.new(2, 4) }
      let(:game) { ProxxGame.new(board) }

      it 'changes state to LOST' do
        game.move(0, 0)
        expect(game.lost?).to be true
      end
    end

    context 'when all non-hole cells are revealed' do
      # there are no holes on the board
      # so any move leads to a win
      let(:board) { Board.new(2, 0) }
      let(:game) { ProxxGame.new(board) }
      it 'changes state to WIN' do
        game.move(0, 1)
        expect(game.won?).to be true
      end
    end
  end
end
