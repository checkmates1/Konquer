class Game < ActiveRecord::Base
  has_many :pieces
  belongs_to :black_player
  belongs_to :white_player
  belongs_to :active_player

  delegate :pawns, :rooks, :knights, :bishops, :queens, :kings, to: :pieces
  scope :available, -> { where('white_player_id IS NULL OR black_player_id IS NULL') }
  def populate_board!
    #- white - 16
    # Pawn - 8
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 0, color: 'white')
    end
    # Rook - 2
    pieces.create(type: 'Rook', x_position: 0, y_position: 0, color: 'white')
    pieces.create(type: 'Rook', x_position: 7, y_position: 0, color: 'white')
    # Knight - 2
    pieces.create(type: 'Knight', x_position: 1, y_position: 0, color: 'white')
    pieces.create(type: 'Knight', x_position: 6, y_position: 0, color: 'white')
    # Bishop - 2
    pieces.create(type: 'Bishop', x_position: 2, y_position: 0, color: 'white')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 0, color: 'white')
    # Queen
    pieces.create(type: 'Queen', x_position: 4, y_position: 0, color: 'white')
    # King
    pieces.create(type: 'King', x_position: 3, y_position: 0, color: 'white')
    #- black - 16
    # Pawn - 8
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 7, color: 'black')
    end
    # Rook - 2
    pieces.create(type: 'Rook', x_position: 0, y_position: 7, color: 'black')
    pieces.create(type: 'Rook', x_position: 7, y_position: 7, color: 'black')
    # Knight - 2
    pieces.create(type: 'Knight', x_position: 1, y_position: 7, color: 'black')
    pieces.create(type: 'Knight', x_position: 6, y_position: 7, color: 'black')
    # Bishop - 2
    pieces.create(type: 'Bishop', x_position: 2, y_position: 7, color: 'black')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 7, color: 'black')
    # Queen
    pieces.create(type: 'Queen', x_position: 3, y_position: 7, color: 'black')
    # King
    pieces.create(type: 'King', x_position: 4, y_position: 7, color: 'black')
  end
end
