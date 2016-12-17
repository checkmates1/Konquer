class Game < ActiveRecord::Base
  has_many :pieces
  belongs_to :black_player
  belongs_to :white_player
  belongs_to :active_player

  delegate :pawns, :rooks, :knights, :bishops, :queens, :kings, to: :pieces
  scope :available, -> { where('white_player_id IS NULL OR black_player_id IS NULL') }
end
