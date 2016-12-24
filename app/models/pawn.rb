class Pawn < Piece
  def valid_move?(destination_x, destination_y)
    x_difference = x_position - destination_x
    y_difference = destination_y - y_position
    return true if vertical_move(destination_y, x_difference, y_difference)
    return true if horizontal_move(destination_x, x_difference, y_difference)
    false
  end

  private

  def vertical_move(destination_y, x_difference, y_difference)
    return false unless y_difference == 1 && x_difference.zero?
    return true unless vertical_obstruction?(destination_y, x_difference, y_difference)
    false
  end

  # how to test for pawns first move??
  # capture logic???
  def horizontal_move(destination_x, x_difference, y_difference)
    return false unless y_difference.zero? && x_difference.abs == 1
    return false unless horizontal_obstruction?(destination_x, x_difference, y_difference)
    false
  end
end
