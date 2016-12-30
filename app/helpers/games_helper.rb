module GamesHelper
  def render_piece(x, y)
    if piece = @game.pieces.find_by(x_position: x, y_position: y)
     return link_to "#{piece.type} #{piece.color}", game_piece_path(@game, piece)
   end 
  end
end
