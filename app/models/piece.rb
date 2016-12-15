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
    return true if obstructed_horizontally?(destination_x, destination_y)
    return true if obstructed_vertically?(destination_x, destination_y)
    return true if obstructed_diagonally?(destination_x, destination_y)
    return nil if !((y_position - destination_y == 0 && x_position - destination_x != 0) || (x_position - destination_x == 0 && y_position - destination_y != 0) || (y_position - destination_y == x_position - destination_x))
    false
  end

  private

  def obstructed_horizontally?(destination_x, destination_y)
    # first line should be a "guard statement". It checks if this method should even be run
    # Is this even a horizontal move? 
    return false unless (y_position - destination_y == 0 && x_position - destination_x != 0) # is the move horizontal?
    for i in x_position..destination_x
      return true if i != nil
    end
    # after the guard statement, we know this move is horizontal. 
    # So check if any pieces exist between the start and destination. Return true if any exist
  end

  def obstructed_vertically?(destination_x, destination_y)
    return false unless (x_position - destination_x == 0 && y_position - destination_y != 0) 
    for i in y_position..destination_y
      return true if i != nil
    end
  end

  def obstructed_diagonally?(destination_x, destination_y)
    return false unless (y_position - destination_y == x_position - destination_x) 
    for i in x_position..destination_x
      for j in y_position..destination_y
        return true if i != nil && j != nil
      end
    end
  end

end
