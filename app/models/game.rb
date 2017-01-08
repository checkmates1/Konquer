class Game < ActiveRecord::Base
  has_many :pieces
  belongs_to :black_player, class_name: 'User'
  belongs_to :white_player, class_name: 'User'
  belongs_to :active_player, class_name: 'User'

  delegate :pawns, :rooks, :knights, :bishops, :queens, :kings, to: :pieces
  scope :available, -> { where('white_player_id IS NULL OR black_player_id IS NULL') }

  def populate_board!
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 1, color: 'white')
    end
    pieces.create(type: 'Rook', x_position: 0, y_position: 0, color: 'white')
    pieces.create(type: 'Rook', x_position: 7, y_position: 0, color: 'white')
    pieces.create(type: 'Knight', x_position: 1, y_position: 0, color: 'white')
    pieces.create(type: 'Knight', x_position: 6, y_position: 0, color: 'white')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 0, color: 'white')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 0, color: 'white')
    pieces.create(type: 'Queen', x_position: 4, y_position: 0, color: 'white')
    pieces.create(type: 'King', x_position: 3, y_position: 0, color: 'white')
    (0..7).each do |i|
      pieces.create(type: 'Pawn', x_position: i, y_position: 6, color: 'black')
    end
    pieces.create(type: 'Rook', x_position: 0, y_position: 7, color: 'black')
    pieces.create(type: 'Rook', x_position: 7, y_position: 7, color: 'black')
    pieces.create(type: 'Knight', x_position: 1, y_position: 7, color: 'black')
    pieces.create(type: 'Knight', x_position: 6, y_position: 7, color: 'black')
    pieces.create(type: 'Bishop', x_position: 2, y_position: 7, color: 'black')
    pieces.create(type: 'Bishop', x_position: 5, y_position: 7, color: 'black')
    pieces.create(type: 'Queen', x_position: 3, y_position: 7, color: 'black')
    pieces.create(type: 'King', x_position: 4, y_position: 7, color: 'black')
  end

  def check?
    white_king = pieces.find_by(type: 'King', color: 'white')
    black_king = pieces.find_by(type: 'King', color: 'black')
    king_in_check?(white_king) || king_in_check?(black_king)
  end

  def king_in_check?(king, x = king.x_position, y = king.y_position)
    enemy_pieces = remaining_pieces(opposite_color(king.color)) # creates array of enemy pieces
    enemy_pieces.each do |piece|
      if piece.valid_move?(x, y)
        @piece_in_check = piece # stores piece that has king in check
        return true
      end
    end
    false
  end

  def stalemate?
    # get king
    color = active_player_id == white_player_id ? 'white' : 'black'
    king = pieces.find_by(type: 'King', color: color)

    # check moves
    return false if kings_in_check?(king)
    return false if king_has_valid_move?(king)
  end

  private

  def king_has_valid_move?(king)
    (-1..1).each do |x|
      (-1..1).each do |y|
        return false if x.zero? && y.zero?
        destination_x = x_position + x
        destination_y = y_position + y
        king.valid_move?(destination_x, destination_y)
      end
    end
  end

  def remaining_pieces(color) # creates an array of the remaining pieces w/desired color
    pieces.includes(:game).where('color = ? and status = 1', color == 'white' ? 0 : 1).to_a
  end

  def opposite_color(color) # returns the opposite color
    color == 'white' ? 'black' : 'white'
  end
end
