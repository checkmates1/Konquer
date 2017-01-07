module PiecesHelper
  def render_piece_selected(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y, game_id: @game.id)
    return false unless @selected_piece.present?
    if @selected_piece.x_position == x && @selected_piece.y_position == y
      content_tag(:div, 'Selected piece', class: ['selected'])
    elsif piece
      link_to "#{piece.type} #{piece.color}", game_piece_path(@game, piece)
    else
      button_to('Move', game_piece_path(@game, @selected_piece), method: 'put', params: { x_position: x, y_position: y })
    end
  end
end
