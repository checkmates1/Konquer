module GamesHelper
  def render_piece(x, y)
    pieces = Piece.all
    puts pieces.size
    pieces.each do |piece|
      puts piece.type
      if piece.x_position == x && piece.y_position == y
        return "#{piece.type} #{piece.color}"
      end
    end
    return ""
  end
end
