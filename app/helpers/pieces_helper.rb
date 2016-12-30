module PiecesHelper
  def render_piece_selected(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y, game_id: @game.id)
    return false if !@selected_piece.present?
      if @selected_piece.x_position == x && @selected_piece.y_position == y
        content_tag(:div, 'Selected piece', class: ['selected'])
      elsif piece
        return link_to "#{piece.type} #{piece.color}", game_piece_path(@game, @selected_piece)
      else
        return link_to 'Move To', game_piece_path(@game, @selected_piece), :method => :put
      end
  end
end
