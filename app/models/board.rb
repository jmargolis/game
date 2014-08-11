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

  def place_square_at(column)

  end

  private

  def clear_bottom_row
    @rows.shift
  end
end