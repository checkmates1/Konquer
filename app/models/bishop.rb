class Bishop < Piece
  def valid_move?(destination_x, destination_y)
    x_difference = x_position - destination_x
    y_difference = y_position - destination_y
    return true if diagonal_move(destination_x, destination_y, x_difference, y_difference)
    false
  end

  private

  def diagonal_move(destination_x, destination_y, x_difference, y_difference)
    return false unless x_difference.abs == y_difference.abs && !x_difference.zero?
    return false unless (0..7).cover?(destination_x) && (0..7).cover?(destination_y)
    return true unless diagonal_obstruction?(destination_x, destination_y, x_difference, y_difference)
    false
  end
end
