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
end
RSpec.describe '.populate_board!' do
  it 'creates correct # of pieces' do
    game = FactoryGirl.create(:game)
    expect(game.pieces.length).to eq 32

    expect(game.pawns.length).to eq 16
    expect(game.rooks.length).to eq 4
    expect(game.knights.length).to eq 4
    expect(game.bishops.length).to eq 4
    expect(game.queens.length).to eq 2
    expect(game.kings.length).to eq 2
  end
end
