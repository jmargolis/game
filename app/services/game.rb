class Game

  MAX_MOVES = 10
  PIECES = [:square]

  def self.start
    board = Board.new
    MAX_MOVES.times { move(board) }
  end

  def self.move(board)
    piece = new_piece
    position = position_piece(board, piece)
    board.drop_piece_at(piece, position)
    board.clear_filled_bottom_rows
  end

  def self.new_piece
    PIECES.sample
  end

  def self.position_piece(board, piece)
    #FIXME: for now, randomly selecting a position
    rand(0..Row::NUM_COLUMNS-2)
  end

end

