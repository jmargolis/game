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

  #FIXME: dup code
  def fill_row(row)
    row.cells.each(&:fill)
  end
end