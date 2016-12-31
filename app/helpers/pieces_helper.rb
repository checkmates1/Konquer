module PiecesHelper
  def render_piece_selected(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y, game_id: @game.id)
    return false unless @selected_piece.present?
    if @selected_piece.x_position == x && @selected_piece.y_position == y
      content_tag(:div, 'Selected piece', class: ['selected'])
    elsif piece = @game.pieces.find_by(x_position: x, y_position: y)
      link_to "#{piece.type} #{piece.color}", game_path(@game)
    else
      link_to "move to", game_path(@game)


    end
  end
end
