class Game

  MAX_MOVES = 10
  PIECES = [:square]

  def self.start
    board = Board.new
    MAX_MOVES.times { move(board) }
    board
  end

  def self.move(board)
    piece = new_piece
    position = position_piece(board, piece)
    board.drop_piece_at(piece, position)
    board.clear_filled_bottom_rows
    board
  end

  def self.new_piece
    PIECES.sample
  end

  def self.position_piece(board, piece)
    board.best_position_for_square
  end

end

