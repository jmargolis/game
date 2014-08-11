class Row
  NUM_COLUMNS = 8

  def initialize
    @cells = []
    NUM_COLUMNS.times do
      @cells << Cell.new
    end
  end

  def empty?
    @cells.all?(&:empty?)
  end

  def full?
    @cells.all?(&:occupied?)
  end

  def has_room?
    @cells.any?(&:empty?)
  end

  def has_room_for_square_at?(position)
    @cells[position].empty? && @cells[position + 1].empty?
  end

  def index_with_room_for_square
    (0..NUM_COLUMNS-2).find{ |position| has_room_for_square_at?(position) }
  end

  def clear
    @cells.each(&:clear)
  end

  def fill
    @cells.each(&:fill)
  end

  def cells
    @cells
  end

  def eql?(row)
    [0...NUM_COLUMNS-1].all?{ |i| cells[i].eql?(row.cells[i]) }
  end
end