class Game

  MAX_MOVES = 10
  PIECES = [:square]

  def self.start
    board = Board.new
    MAX_MOVES.times { move(board) }
  end

  def self.move(board)
    piece = new_piece
    drop(piece, board)
  end

  def self.new_piece
    PIECES.sample
  end

  def self.drop(piece, board)
    column = location_to_drop(piece)

  end

end

