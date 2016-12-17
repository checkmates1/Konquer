require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'obstructed method' do
    it 'should return nil if invalid move' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4, type: 'Rook', game: game)
      expect(piece.obstructed?(1, 3)).to eq nil
    end

    it 'should return false if not obstructed on right' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 2, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 5, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(4, 2)).to eq false
    end

    it 'should return true if obstructed on left' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 2, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(0, 2)).to eq true
    end

    it 'should return true if obstructed below' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 0, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(2, 4)).to eq true
    end

    it 'should return true if obstructed above' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, x_position: 2, y_position: 4, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(2, 0)).to eq true
    end

    it 'should return true if obstructed diagonal down-right' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, x_position: 0, y_position: 0, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(4, 4)).to eq true
    end

    it 'should return true if obstructed diagonal up-left' do
      game = FactoryGirl.create(:game)
      piece = FactoryGirl.create(:piece, x_position: 4, y_position: 4, type: 'Rook', game: game)
      FactoryGirl.create(:piece, x_position: 2, y_position: 2, type: 'Rook', game: game)
      expect(piece.obstructed?(0, 0)).to eq true
    end
  end
end
