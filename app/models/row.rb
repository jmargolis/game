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

  def clear
    @cells.each(&:clear)
  end

  def cells
    @cells
  end

  def eql?(row)
    [0...NUM_COLUMNS-1].all?{ |i| cells[i].eql?(row.cells[i]) }
  end
end