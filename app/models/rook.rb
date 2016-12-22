class Rook < Piece
  def valid_move?(destination_x, destination_y)
    x_difference = x_position - destination_x
    y_difference = y_position - destination_y
    return true if vertical_move(destination_y, x_difference, y_difference)
    return true if horizontal_move(destination_x, x_difference, y_difference)
    false
  end

  private

  def vertical_move(destination_y, x_difference, y_difference)
    return false unless x_difference.zero? && !y_difference.zero?
    return false unless destination_y > 0 && destination_y < 8
    return true unless vertical_obstruction?(destination_y, x_difference, y_difference)
    false
  end

  def horizontal_move(destination_x, x_difference, y_difference)
    return false unless y_difference.zero? && !x_difference.zero?
    return false unless destination_x > 0 && destination_x < 8
    return true unless horizontal_obstruction?(destination_x, x_difference, y_difference)
    false
  end
end
