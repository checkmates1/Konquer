require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "obstructed method" do
    it "should return nil if invalid move" do
      piece = Piece.create(row: 5, column: 5)
      expect(piece.obstructed?(1,3)).to eq nil
    end

    it "should return true if obstructed on right" do
      pieceA = Piece.create(row: 1, column: 1)
      pieceB = Piece.create(row: 3, column: 1)
      expect(pieceA.obstructed?(5,1)).to eq true
    end

    it "should return true if obstructed on left" do
      pieceA = Piece.create(row: 5, column: 1)
      pieceB = Piece.create(row: 3, column: 1)
      expect(pieceA.obstructed?(1,1)).to eq true
    end

    it "should return true if obstructed on bottom" do
      pieceA = Piece.create(row: 1, column: 1)
      pieceB = Piece.create(row: 1, column: 3)
      expect(pieceA.obstructed?(1,5)).to eq true
    end

    it "should return true if obstructed on top" do
      pieceA = Piece.create(row: 1, column: 5)
      pieceB = Piece.create(row: 1, column: 3)
      expect(pieceA.obstructed?(1,1)).to eq true
    end

    it "should return true if obstructed diagonal down-right" do
      pieceA = Piece.create(row: 1, column: 1)
      pieceB = Piece.create(row: 3, column: 3)
      expect(pieceA.obstructed?(5,5)).to eq true
    end

    it "should return true if obstructed diagonal up-left" do
      pieceA = Piece.create(row: 5, column: 5)
      pieceB = Piece.create(row: 3, column: 3)
      expect(pieceA.obstructed?(1,1)).to eq true
    end

  end
end
