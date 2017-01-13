module GamesHelper
  def render_piece(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y)
    link_to "#{piece.type} #{piece.color}", game_piece_path(@game, piece) if piece
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end

  # def assign_player_turn
  #   return "White Player's Turn" if @game.swap_active_player == @game.white_player
  #   "Black Player's Turn" if @game.swap_active_player == @game.black_player
  # end

  def whose_turn_text
    return "Your turn!" if current_user == @game.active_player
    "Not your turn yet."
  end
end
