class Game < ActiveRecord::Base
  has_many :pieces
  belongs_to :black_player
  belongs_to :white_player
  belongs_to :active_player

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
    kings_in_check?('white') || kings_in_check?('black')
  end

  private

  def remaining_pieces(color) # creates an array of the remaining pieces w/desired color
    pieces.includes(:game).where('color = ? and status = 1', color == 'white' ? 0 : 1).to_a
  end

  def opposite_color(color) # returns the opposite color
    color == 'white' ? 'black' : 'white'
  end

  def kings_in_check?(color)
    king = pieces.find_by(type: 'King', color: color)
    enemy = remaining_pieces(opposite_color(color)) # creates array of enemy pieces
    enemy.each do |piece|
      if piece.valid_move?(king.x_position, king.y_position)
        @piece_in_check = piece # stores piece that has king in check
        return true
      end
    end
    false
  end



  def check_mate?
    checkmate = true
    friendly = remaining_pieces(color)
    friendly.each do |piece|
      if all_possible_moves.piece
        checkmate = false unless kings_in_check?
        end
    end
    if checkmate == true
      return true
    else
      false
    end
  end

  def all.moves(piece)
    all_possible_moves = []
    piece.each do |move|
      all_possible_moves[move] = piece.move
    end
    all_possible_moves
  end 
end
