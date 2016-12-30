module PiecesHelper
  def render_piece_selected(x, y)
    current_piece = @game.pieces.find_by(x_position: x, y_position: y, game_id: @game.id)
    if @piece.present?
      if @piece.x_position == x && @piece.y_position == y
        content_tag(:div, "WOW", class: ["selected"])
      elsif current_piece
        return link_to "#{current_piece.type} #{current_piece.color}", piece_path(@game, @piece)
      else
        return "Empty"
      end
    end
  end
end
