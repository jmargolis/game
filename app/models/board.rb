class Board
  NUM_ROWS = 10

  def initialize
    @rows = []
    NUM_ROWS.times do
      @rows << Row.new
    end
  end

  def top_row_with_room
    @rows.find(&:has_room?)
  end

  def index_of_top_row_with_room_for_square_at(position)
    @rows.index{ |row| row.has_room_for_square_at?(position) }
  end

  def bottom_row
    @rows.first
  end

  def clear_filled_bottom_rows
    while bottom_row.full? do
      clear_bottom_row
    end
  end

  def rows
    @rows
  end

  def drop_piece_at(piece, position)
    case piece
      when :square
        drop_square_at(position)
    end
  end

  def drop_square_at(position)
    index = index_of_top_row_with_room_for_square_at(position)
    [index, index + 1].each do |i|
      row = @rows[i]
      row.cells[position].fill
      row.cells[position + 1].fill
    end
  end

  private

  def clear_bottom_row
    @rows.shift
  end
end