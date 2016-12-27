module GamesHelper
  def render_piece(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y)
    return "#{piece.type} #{piece.color} " if piece
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end
end
