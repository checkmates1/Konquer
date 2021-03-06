module GamesHelper
  def render_piece(x, y)
    piece = @game.pieces.find_by(x_position: x, y_position: y)
    link_to image_tag(image_name(piece), class: 'responsive-img'), game_piece_path(@game, piece) if piece && @game.white_player && @game.black_player
  end

  def image_name(piece)
    'pieces/' + piece.type + ' ' + piece.color + '.png'
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end
end
