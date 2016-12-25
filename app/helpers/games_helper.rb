module GamesHelper
  def render_piece(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y)
    return "#{piece.type} #{piece.color} " if piece
  end
end
