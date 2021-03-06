class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  enum status: [:dead, :alive]
  enum color: [:white, :black]

  validates :type, presence: true

  scope :pawns, -> { where(type: 'Pawn') }
  scope :rooks, -> { where(type: 'Rook') }
  scope :knights, -> { where(type: 'Knight') }
  scope :bishops, -> { where(type: 'Bishop') }
  scope :queens, -> { where(type: 'Queen') }
  scope :kings, -> { where(type: 'King') }

  def types
    %w(Pawn Rook Knight Bishop Queen King)
  end

  def move_to!(destination_x, destination_y)
    destination = game.pieces.find_by(x_position: destination_x, y_position: destination_y)
    return unless valid_move?(destination_x, destination_y)
    return move_position(destination_x, destination_y) if destination.nil?
    return capture_position(destination, destination_x, destination_y) if destination.color == color
  end

  def obstructed?(destination_x, destination_y)
    x_difference = x_position - destination_x
    y_difference = y_position - destination_y
    return true if diagonal_obstruction?(destination_x, destination_y, x_difference, y_difference)
    return true if vertical_obstruction?(destination_y, x_difference, y_difference)
    return true if horizontal_obstruction?(destination_x, x_difference, y_difference)
    false
  end

  protected

  def move_position(destination_x, destination_y)
    update_attributes(x_position: destination_x, y_position: destination_y)
  end

  def capture_position(destination, destination_x, destination_y)
    destination.update_attributes(x_position: nil, y_position: nil, status: :dead)
    update_attributes(x_position: destination_x, y_position: destination_y)
  end

  def diagonal_obstruction?(destination_x, destination_y, x_difference, y_difference)
    return false unless x_difference.abs == y_difference.abs && x_difference != 0
    y_direction = y_difference <=> 0
    (x_difference < 0 ? ((x_position + 1)...destination_x) : ((destination_x + 1)...x_position)).each_with_index do |x, i|
      y = x_difference < 0 ? y_position + ((i + 1) * -y_direction) : destination_y + ((i + 1) * y_direction)
      return true if game.pieces.exists?(x_position: x, y_position: y)
    end
    false
  end

  def vertical_obstruction?(destination_y, x_difference, y_difference)
    return false unless x_difference.zero? && y_difference != 0
    (y_difference < 0 ? ((y_position + 1)...destination_y) : ((destination_y + 1)...y_position)).each do |y|
      return true if game.pieces.exists?(x_position: x_position, y_position: y)
    end
    false
  end

  def horizontal_obstruction?(destination_x, x_difference, y_difference)
    return false unless y_difference.zero? && x_difference != 0
    (x_difference < 0 ? ((x_position + 1)...destination_x) : ((destination_x + 1)...x_position)).each do |x|
      return true if game.pieces.exists?(x_position: x, y_position: y_position)
    end
    false
  end
end
