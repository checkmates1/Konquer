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
    return true if check_diagonal?(destination_x, destination_y, x_difference, y_difference)
    return true if check_vertical?(destination_x, destination_y, x_difference, y_difference)
    return true if check_horizontal?(destination_x, destination_y, x_difference, y_difference)
    nil
  end

  def check_diagonal?(destination_x, destination_y, x_difference, y_difference)
    return false unless x_difference.abs == y_difference.abs && x_difference != 0
    y_direction = -y_difference <=> 0
    if x_difference < 0
      (x_position..destination_x).each_with_index do |x, i|
        y = y_position + (i * y_direction)
        return true if self.game.pieces.exists?(x_position: x, y_position: y)
      end
    else
      (destination_x..x_position).each.with_index do |x, i|
        y = y_position + (i * y_direction)
        return true if self.game.pieces.exists?(x_position: x, y_position: y)
      end
    end
  end

  def check_vertical?(destination_x, destination_y, x_difference, y_difference)
    return false unless x_difference.zero? && y_difference != 0
    if y_difference < 0
      (y_position..destination_y).each do |y|
        return true if self.game.pieces.exists?(x_position: x_position, y_position: y)
      end
    else
      (destination_y..y_position).each do |y|
        return true if self.game.pieces.exists?(x_position: x_position, y_position: y)
      end
    end
  end

  def check_horizontal?(destination_x, destination_y, x_difference, y_difference)
    return false unless y_difference.zero? && x_difference != 0
    if x_difference < 0
      (x_position..destination_x).each do |x|
        return true if self.game.pieces.exists?(x_position: x, y_position: y_position)
      end
    else
      (destination_x..x_position).each do |x|
        return true if self.game.pieces.exists?(x_position: x, y_position: y_position)
      end
    end
  end
end
