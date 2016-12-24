class Knight < Piece
  def valid_move?(destination_x, destination_y)
    return false if x_position == destination_x
    return false if y_position == destination_y
    valid_move_distance?(destination_x, destination_y)
  end

  private

  def valid_move_distance?(destination_x, destination_y)
    (x_position - destination_x).abs + (y_position - destination_y).abs == 3
  end
end
