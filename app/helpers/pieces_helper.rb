module PiecesHelper
  # def render_piece(x, y, game_id)
  #   if piece = @game.pieces.find_by(x_position: x, y_position: y, game_id: @game.id)
  #    return link_to "#{piece.type} #{piece.color}", game_piece_path(@game, @piece)
  #   else
  #    return "Move Too"
  #  end 
  # end

  # def render_piece_selected(x, y)
  #   if piece = @game.pieces.find_by(x_position: x, y_position: y)
  #     render text: 'selected'
  #   else
  #    return "Move Too"
  #  end 
  # end

  def draw_square_background(x, y)
    current_piece = piece_for_square(x, y)
    link_to piece_path(id: @selected_piece, piece: { x_position: x, y_position: y }),
            method: 'PUT',
            class: "#{'selected' if selected?(current_piece)}" do
      content_tag :div, class: ".div.row div--#{background_color(x, y)}" do
        draw_square_content(current_piece)
      end
    end
  end

  def draw_square_content(current_piece)
    return unless current_piece
    piece_name = "#{current_piece.color.downcase}_#{current_piece.type.downcase}"
  end

  def background_color(x, y)
    if x.odd? && y.odd? || x.even? && y.even?
      'white'
    else
      'black'
    end
  end

  def piece_for_square(x, y)
    piece = @pieces.first
    return @pieces.shift if piece && piece.x_position == x && piece.y_position == y
  end

  def selected?(current_piece)
    current_piece == @selected_piece
  end

end
