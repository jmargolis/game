class Cell
  def initialize
    clear
  end

  def occupied?
    @occupied
  end

  def empty?
    !@occupied
  end

  def fill
    @occupied = true
  end

  def clear
    @occupied = false
  end

  def eql?(cell)
    occupied? == cell.occupied?
  end
end