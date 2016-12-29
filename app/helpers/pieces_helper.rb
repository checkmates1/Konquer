module PiecesHelper
  def render_piece(x, y)
    if piece = @game.pieces.find_by(x_position: x, y_position: y)
     return link_to "#{piece.type} #{piece.color}", game_piece_path(@game, @piece)
    else
     return "Move Too"
   end 
  end

  def render_piece_selected(x, y)
    if piece = @game.pieces.find_by(x_position: x, y_position: y)
      render text: 'selected'
     # return link_to "#{piece.type} #{piece.color}", piece_path
    else
     return "Move Too"
   end 
  end
end
