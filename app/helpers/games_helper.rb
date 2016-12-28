module GamesHelper
  def render_piece(x, y)
    if piece = @game.pieces.find_by(x_position: x, y_position: y)
     return "#{piece.type} #{piece.color}"
    else
     return "Move Too"
   end 
  end
end
