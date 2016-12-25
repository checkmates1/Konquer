class Pawn < Piece
  def valid_move?(destination_x, destination_y)
    x_difference = x_position - destination_x
    y_difference = destination_y - y_position if white?
    y_difference = y_position - destination_y if black?
    return true if vertical_move(destination_y, x_difference, y_difference)
    return true if horizontal_move(destination_x, x_difference, y_difference)
    false
  end

  private

  def vertical_move(destination_y, x_difference, y_difference)
    return true if y_difference == 2 && first_move?
    return true if y_difference == 1 && x_difference.zero?
    return false if vertical_obstruction?(destination_y, x_difference, y_difference)
    false
  end

  def horizontal_move(destination_x, x_difference, y_difference)
    return false unless y_difference.zero? && x_difference.abs == 1
    return false unless horizontal_obstruction?(destination_x, x_difference, y_difference)
    false
  end

  def first_move?
    return true if y_position == 1 && white?
    return true if y_position == 6 && black?
  end
end
