require 'spec_helper'

describe 'board' do
  let(:board) { Board.new }
  let(:rows) { board.rows }

  describe '#top_row_with_room' do
    it 'returns first row on empty board' do
      expect(board.top_row_with_room).to eq(rows[0])
    end

    it 'returns first row when partially full' do
      partially_fill_row(rows[0])
      expect(board.top_row_with_room).to eq(rows[0])
    end

    it 'returns second row when first row is full' do
      fill_row(rows[0])
      expect(board.top_row_with_room).to eq(rows[1])
    end

    it 'returns second row when first row is full and second row is partially full' do
      fill_row(rows[0])
      partially_fill_row(rows[1])
      expect(board.top_row_with_room).to eq(rows[1])
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

  def fill_row(row)
    row.cells.each(&:fill)
  end

  def partially_fill_row(row)
    row.cells[0..1].each(&:fill)
  end

end