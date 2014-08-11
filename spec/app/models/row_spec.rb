require 'spec_helper'

describe 'row' do
  let(:row) { Row.new }
  let(:cells) { row.instance_variable_get(:@cells) }

  describe '#empty?' do
    it 'starts off true' do
      expect(row.empty?).to be_true
    end

    it 'returns false when at least one cell is filled' do
      cells.sample.fill
      expect(row.empty?).to be_false
    end
  end

  describe '#full?' do
    it 'starts off false' do
      expect(row.full?).to be_false
    end

    it 'returns true when all cells are filled' do
      cells.each(&:fill)
      expect(row.full?).to be_true
    end

    it 'returns false when only some cells are filled' do
      cells[0..1].each(&:fill)
      expect(row.full?).to be_false
    end
  end

  describe '#has_room?' do
    it 'starts off true' do
      expect(row.has_room?).to be_true
    end

    it 'returns false when all cells are filled' do
      cells.each(&:fill)
      expect(row.has_room?).to be_false
    end

    it 'returns true when only some cells are filled' do
      cells[0..1].each(&:fill)
      expect(row.has_room?).to be_true
    end
  end

  describe '#has_room_for_square_at?' do
    let(:result) { row.has_room_for_square_at?(3) }

    it 'returns false when position is taken' do
      cells[3].fill
      expect(result).to be_false
    end

    it 'returns false when position is empty, but next position is taken' do
      cells[4].fill
      expect(result).to be_false
    end

    it 'returns true when both position and next are empty' do
      cells.each(&:fill)
      cells[3..4].each(&:clear)
      expect(result).to be_true
    end
  end

  describe '#index_with_room_for_square' do
    let(:result) { row.index_with_room_for_square }

    it 'returns nil when there is no room' do
      row.cells.each(&:fill)
      expect(result).to be_false
    end

    it 'returns first position with 2 empty cells in a row' do
      row.cells[0..3].each(&:fill)
      expect(result).to eq(4)
    end
  end

  describe '#clear' do
    before do
      cells.each(&:fill)
      expect(row.empty?).to be_false
    end

    it 'causes row to be empty' do
      row.clear
      expect(row.empty?).to be_true
    end
  end

  describe '#eql?' do
    let(:other_row) { Row.new }
    let(:result) { row.eql?(other_row) }

    it 'returns true when both are empty' do
      expect(result).to be_true
    end

    it 'returns true when both are full' do
      fill_row(row)
      fill_row(other_row)
      expect(result).to be_true
    end

    it 'returns false when one is empty and the other is full' do
      fill_row(row)
      expect(result).to be_false
    end
  end

  #FIXME: dup code, move to helper (or model)
  def fill_row(row)
    row.cells.each(&:fill)
  end
end