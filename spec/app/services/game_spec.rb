require 'spec_helper'

describe 'game' do
  describe '.start' do
    let(:final_board) { Game.start }

    it 'returns board with correct end state' do
      expect(final_board.rows[0].cells[0..4].each(&:occupied?))
      expect(final_board.rows[0].cells[5..7].each(&:empty?))
      expect(final_board.rows[1].cells[0..4].each(&:occupied?))
      expect(final_board.rows[1].cells[5..7].each(&:empty?))
      expect(final_board.rows[2].cells.each(&:empty?))
      expect(final_board.rows[3].cells.each(&:empty?))
    end
  end

  describe '.move' do
    let(:board) { Board.new }
    let(:final_board) { Game.move(board) }

    it 'places square in first position' do
      expect(final_board.rows[0].cells[0..2].each(&:occupied?))
      expect(final_board.rows[0].cells[3..7].each(&:empty?))
      expect(final_board.rows[1].cells[0..2].each(&:occupied?))
      expect(final_board.rows[1].cells[3..7].each(&:empty?))
      expect(final_board.rows[2].cells.each(&:empty?))
    end
  end
end

