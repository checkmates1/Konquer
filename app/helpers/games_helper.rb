module GamesHelper
  def render_piece(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y)
    link_to "#{piece.type} #{piece.color}", game_piece_path(@game, piece) if piece
  end
end
