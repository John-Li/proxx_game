describe Cell do
  let(:cell) { Cell.new }

  describe '#initialize' do
    it 'creates a new cell with default values' do
      expect(cell.hole?).to be false
      expect(cell.revealed?).to be false
      expect(cell.adjacent_holes).to eq(0)
    end
  end

  describe '#reveal' do
    it 'reveals the cell' do
      cell.reveal
      expect(cell.revealed?).to be true
    end
  end

  describe '#revealed?' do
    it 'returns false when the cell is not revealed' do
      expect(cell.revealed?).to be false
    end

    it 'returns true when the cell is revealed' do
      cell.reveal
      expect(cell.revealed?).to be true
    end
  end

  describe '#to_hole' do
    it 'turns the cell into a hole' do
      cell.to_hole
      expect(cell.hole?).to be true
    end
  end

  describe '#hole?' do
    it 'returns false when the cell is not a hole' do
      expect(cell.hole?).to be false
    end

    it 'returns true when the cell is a hole' do
      cell.to_hole
      expect(cell.hole?).to be true
    end
  end
end
