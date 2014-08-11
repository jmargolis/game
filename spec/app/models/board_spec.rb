require 'spec_helper'

describe 'board' do
  let(:board) { Board.new }
  let(:rows) { board.rows }

  describe '#top_row_with_room' do
    it 'returns first row on empty board' do
      expect(board.top_row_with_room).to eq(rows[0])
    end

    it 'returns first row when partially full' do
      rows[0].cells[0..1].each(&:fill)
      expect(board.top_row_with_room).to eq(rows[0])
    end

    it 'returns second row when first row is full' do
      rows[0].fill
      expect(board.top_row_with_room).to eq(rows[1])
    end

    it 'returns second row when first row is full and second row is partially full' do
      rows[0].fill
      rows[1].cells[0..1].each(&:fill)
      expect(board.top_row_with_room).to eq(rows[1])
    end
  end

  describe '#index_of_top_row_with_room_for_square_at' do
    it 'returns first row with room for square piece' do
      rows[0].cells[3].fill
      rows[1].cells[4].fill
      rows[2].cells[0..2].each(&:fill)

      expect(board.index_of_top_row_with_room_for_square_at(3)).to eq(2)
    end
  end

  describe '#index_of_top_row_with_room_for_square' do
    let(:result) { board.index_of_top_row_with_room_for_square }

    it 'returns first row by default' do
      expect(result).to eq(0)
    end

    it 'returns index of first row that has two empty cells in a row' do
      rows[0].cells.each(&:fill)
      rows[1].cells[1..Row::NUM_COLUMNS-1].each(&:fill)
      rows[2].cells[0..2].each(&:fill)

      expect(result).to eq(2)
    end
  end

  describe '#best_position_for_square' do
    let(:result) { board.best_position_for_square }

    it 'returns first column by default' do
      expect(result).to eq(0)
    end

    it 'returns best position' do
      rows[0].cells.each(&:fill)
      rows[1].cells[1..Row::NUM_COLUMNS-1].each(&:fill)
      rows[2].cells[0..2].each(&:fill)

      expect(result).to eq(3)
    end
  end

  describe '#drop_square_at' do
    before do
      rows[0].cells[3].fill
      rows[1].cells[4].fill
      rows[2].cells[0..2].each(&:fill)

      board.drop_square_at(3)
    end

    it 'fills appropriate cells' do
      expect(rows[2].cells[3..4].all?(&:occupied?)).to be_true
      expect(rows[3].cells[3..4].all?(&:occupied?)).to be_true
    end

    it 'does not fill other cells' do
      expect(rows[2].cells[5..6].all?(&:empty?)).to be_true
      expect(rows[3].cells[0..2].all?(&:empty?)).to be_true
      expect(rows[4]).to be_empty
    end
  end

  describe '#drop_piece_at' do
    it 'drops square' do
      board.should_receive(:drop_square_at).with(3)
      board.should_receive(:clear_filled_bottom_rows)
      board.drop_piece_at(:square, 3)
    end
  end

  describe '#bottom_row' do
    it 'returns the first row' do
      expect(board.bottom_row).to eq(rows[0])
    end
  end

  describe '#clear_filled_bottom_rows' do
    context 'when board is empty' do
      it 'does nothing' do
        rows_before = rows
        board.clear_filled_bottom_rows

        expect(rows).to eq(rows_before)
      end
    end

    context 'when first two rows are full, and next two rows are partially full' do
      before do
        rows[0].cells.each(&:fill)
        rows[1].cells.each(&:fill)
        rows[2].cells[0..1].each(&:fill)
        rows[3].cells[1..2].each(&:fill)

        board.clear_filled_bottom_rows
      end

      it 'clears out the top two rows (because they move down)' do
        expect(rows[2]).to be_empty
        expect(rows[3]).to be_empty
      end

      it 'makes bottom two rows match the previous top two rows' do
        old_row_2 = Row.new
        old_row_2.cells[0..1].each(&:fill)

        old_row_3 = Row.new
        old_row_3.cells[1..2].each(&:fill)

        expect(rows[0]).to eql(old_row_2)
        expect(rows[1]).to eql(old_row_3)
      end
    end
  end
end