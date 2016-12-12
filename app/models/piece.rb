class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  enum status: [:dead, :alive]
  enum color: [:white, :black]
end
