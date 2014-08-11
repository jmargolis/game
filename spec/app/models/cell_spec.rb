require 'spec_helper'

describe 'cell' do
  let(:cell) { Cell.new }

  describe '#occupied?' do
    it 'starts off false' do
      expect(cell.occupied?).to be_false
    end

    it 'returns true when filled' do
      cell.fill
      expect(cell.occupied?).to be_true
    end
  end

  describe '#empty?' do
    it 'starts off true' do
      expect(cell.empty?).to be_true
    end

    it 'returns false when filled' do
      cell.fill
      expect(cell.empty?).to be_false
    end
  end

  describe '#fill' do
    it 'causes cell to be occupied' do
      cell.fill
      expect(cell.occupied?).to be_true
    end
  end

  describe '#clear' do
    before do
      cell.fill
      expect(cell.empty?).to be_false
    end

    it 'causes cell to be empty' do
      cell.clear
      expect(cell.empty?).to be_true
    end
  end

  describe '#eql?' do
    let(:other_cell) { Cell.new }
    let(:result) { cell.eql?(other_cell) }

    it 'returns true when both are empty' do
      expect(result).to be_true
    end

    it 'returns true when both are occupied' do
      cell.fill
      other_cell.fill
      expect(result).to be_true
    end

    it 'returns false when one is empty and the other is occupied' do
      cell.fill
      expect(result).to be_false
    end
  end
end