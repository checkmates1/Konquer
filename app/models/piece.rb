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

  def obstructed?(destination_x, destination_y)
    x_difference = x_position - destination_x
    y_difference = y_position - destination_y
    return true if diagonal?(destination_x, destination_y, x_difference, y_difference)
    return true if vertical?(destination_y, x_difference, y_difference)
    return true if horizontal?(destination_x, x_difference, y_difference)
    return false if valid_move?(x_difference, y_difference)
    nil
  end

  def diagonal?(destination_x, destination_y, x_difference, y_difference)
    return false unless x_difference.abs == y_difference.abs && x_difference != 0
    y_direction = -y_difference <=> 0
    if x_difference < 0
      ((x_position + 1)...destination_x).each_with_index do |x, i|
        y = y_position + ((i + 1) * y_direction)
        return true if game.pieces.exists?(x_position: x, y_position: y)
      end
    else
      ((destination_x + 1)...x_position).each.with_index do |x, i|
        y = destination_y + ((i + 1) * y_direction)
        return true if game.pieces.exists?(x_position: x, y_position: y)
      end
    end
    false
  end

  def vertical?(destination_y, x_difference, y_difference)
    return false unless x_difference.zero? && y_difference != 0
    if y_difference < 0
      ((y_position + 1)...destination_y).each do |y|
        return true if game.pieces.exists?(x_position: x_position, y_position: y)
      end
    else
      ((destination_y - 1)...y_position).each do |y|
        return true if game.pieces.exists?(x_position: x_position, y_position: y)
      end
    end
    false
  end

  def horizontal?(destination_x, x_difference, y_difference)
    return false unless y_difference.zero? && x_difference != 0
    if x_difference < 0
      ((x_position + 1)...destination_x).each do |x|
        return true if game.pieces.exists?(x_position: x, y_position: y_position)
      end
    else
      ((destination_x - 1)...x_position).each do |x|
        return true if game.pieces.exists?(x_position: x, y_position: y_position)
      end
    end
    false
  end

  def valid_move?(x_difference, y_difference)
    return true if x_difference.abs == y_difference.abs && x_difference != 0
    return true if x_difference.zero? && y_difference != 0
    return true if y_difference.zero? && x_difference != 0
  end
end
