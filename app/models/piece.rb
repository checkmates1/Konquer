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
    current_piece = self

    x_diff = self.x_position - destination_x
    y_diff = self.y_position - destination_y

    if (x_diff == y_diff)
      return 'diagonal'
    elsif (x_diff == 0 && y_diff != 0)
      return 'vertical'
    elsif (y_diff == 0 && x_diff != 0)
      return 'horizontal'
    else
      return nil
    end

  end
end
