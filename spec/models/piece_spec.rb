require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'obstructed method' do
    let(:game) { FactoryGirl.create(:game) }
    it 'should return false if invalid move' do
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4, type: 'Rook', game: game)
      expect(piece.obstructed?(1, 3)).to eq false
    end

    it 'should return false if not obstructed on right' do
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 2, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 5, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(4, 2)).to eq false
    end

    it 'should return true if obstructed on left' do
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 2, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(0, 2)).to eq true
    end

    it 'should return true if obstructed below' do
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 0, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(2, 4)).to eq true
    end

    it 'should return true if obstructed above' do
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 4, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(2, 0)).to eq true
    end

    it 'should return true if obstructed diagonal down-right' do
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 0, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(4, 4)).to eq true
    end

    it 'should return true if obstructed diagonal up-left' do
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(0, 0)).to eq true
    end

    it 'should return true if obstructed diagonal down-right' do
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 4, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(4, 0)).to eq true
    end

    it 'should return true if obstructed diagonal up-left' do
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 0, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(0, 4)).to eq true
    end
  end
  describe '.populate_board!' do
    it 'creates correct number and color of pieces' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.length).to eq 32

      expect(game.pawns.length).to eq 16
      expect(game.rooks.length).to eq 4
      expect(game.knights.length).to eq 4
      expect(game.bishops.length).to eq 4
      expect(game.queens.length).to eq 2
      expect(game.kings.length).to eq 2
      expect(game.pieces.white.length).to eq 16
      expect(game.pieces.black.length).to eq 16
    end
    it 'creates Pawns in correct positions' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.find_by(x_position: 0, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 1, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 2, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 3, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 4, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 5, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 6, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 7, y_position: 1).type).to eq 'Pawn'

      expect(game.pieces.find_by(x_position: 0, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 1, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 2, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 3, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 4, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 5, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 6, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 7, y_position: 6).type).to eq 'Pawn'
    end
    it 'creates Rooks in correct positions' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.find_by(x_position: 0, y_position: 0).type).to eq 'Rook'
      expect(game.pieces.find_by(x_position: 7, y_position: 0).type).to eq 'Rook'
      expect(game.pieces.find_by(x_position: 0, y_position: 7).type).to eq 'Rook'
      expect(game.pieces.find_by(x_position: 7, y_position: 7).type).to eq 'Rook'
    end
    it 'creates Knights in correct positions' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.find_by(x_position: 1, y_position: 0).type).to eq 'Knight'
      expect(game.pieces.find_by(x_position: 6, y_position: 0).type).to eq 'Knight'
      expect(game.pieces.find_by(x_position: 1, y_position: 7).type).to eq 'Knight'
      expect(game.pieces.find_by(x_position: 6, y_position: 7).type).to eq 'Knight'
    end
    it 'creates Bishops in correct positions' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.find_by(x_position: 2, y_position: 0).type).to eq 'Bishop'
      expect(game.pieces.find_by(x_position: 5, y_position: 0).type).to eq 'Bishop'
      expect(game.pieces.find_by(x_position: 2, y_position: 7).type).to eq 'Bishop'
      expect(game.pieces.find_by(x_position: 5, y_position: 7).type).to eq 'Bishop'
    end
    it 'creates Queens and Kings in correct positions' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.find_by(x_position: 4, y_position: 0).type).to eq 'Queen'
      expect(game.pieces.find_by(x_position: 3, y_position: 0).type).to eq 'King'
      expect(game.pieces.find_by(x_position: 3, y_position: 7).type).to eq 'Queen'
      expect(game.pieces.find_by(x_position: 4, y_position: 7).type).to eq 'King'
    end
  end
end
