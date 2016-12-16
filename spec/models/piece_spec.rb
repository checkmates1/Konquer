require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "obstructed method" do
    it "should return nil if invalid move" do
      piece = Piece.create(x_position: 5, y_position: 5)
      expect(piece.obstructed?(1,3)).to eq nil
    end

    it "should return obstruction position if obstructed on right" do
      piece = Piece.create(x_position: 0, y_position: 2)
      expect(piece.obstructed?(4,2)).to eq "2, 2"
    end

    it "should return obstruction position if obstructed on left" do
      piece = Piece.create(x_position: 4, y_position: 2)
      expect(piece.obstructed?(0,2)).to eq "2, 2"
    end

    # it "should return true if obstructed on bottom" do
    #   pieceA = Piece.create(x_position: 1, y_position: 1)
    #   pieceB = Piece.create(x_position: 1, y_position: 3)
    #   expect(pieceA.obstructed?(1,5)).to eq true
    # end
    #
    # it "should return true if obstructed on top" do
    #   pieceA = Piece.create(x_position: 1, y_position: 5)
    #   pieceB = Piece.create(x_position: 1, y_position: 3)
    #   expect(pieceA.obstructed?(1,1)).to eq true
    # end
    #
    # it "should return true if obstructed diagonal down-right" do
    #   pieceA = Piece.create(x_position: 1, y_position: 1)
    #   pieceB = Piece.create(x_position: 3, y_position: 3)
    #   expect(pieceA.obstructed?(5,5)).to eq true
    # end
    #
    # it "should return true if obstructed diagonal up-left" do
    #   pieceA = Piece.create(x_position: 5, y_position: 5)
    #   pieceB = Piece.create(x_position: 3, y_position: 3)
    #   expect(pieceA.obstructed?(1,1)).to eq true
    # end
  end
end
