module PiecesHelper
  def render_piece_selected(x, y)
    return if @game.white_player.nil? || @game.black_player.nil?
    piece = @game.pieces.find_by(x_position: x, y_position: y, game_id: @game.id)
    return false unless @selected_piece.present?
    if @selected_piece.x_position == x && @selected_piece.y_position == y
      content_tag(:div, image_tag(image_name(@selected_piece)), class: ['selected responsive-img'])
    elsif piece
      link_to image_tag(image_name(piece), class: 'responsive-img'), game_piece_path(@game, piece)
    else
      button_to('Move', game_piece_path(@game, @selected_piece), method: 'put', params: { x_position: x, y_position: y })
    end
  end

  def image_name(piece)
    'pieces/' + piece.type + ' ' + piece.color + '.png'
  end
end
