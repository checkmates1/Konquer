module PiecesHelper
  def render_piece_selected(x, y)
    current_piece = @game.pieces.find_by(x_position: x, y_position: y, game_id: @game.id)
    return false if !@piece.present?
      if @piece.x_position == x && @piece.y_position == y
        content_tag(:div, 'Selected piece', class: ['selected'])
      elsif current_piece
        return link_to "#{current_piece.type} #{current_piece.color}", game_piece_path(@game, @piece)
      else
        return link_to 'Move To', game_piece_path(@game, @piece), :method => :put
      end
  end
end
