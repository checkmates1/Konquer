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

RSpec.describe Piece, type: :model do
  describe 'move_to! method with validation' do
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:game) { FactoryGirl.create(:game, white_player_id: user1.id, black_player_id: user2.id) }
    let(:pawn1) { FactoryGirl.create(:pawn, x_position: 0, y_position: 1, color: 'white', game: game) }
    let(:pawn2) { FactoryGirl.create(:pawn, x_position: 1, y_position: 2, color: 'black', game: game) }
    let(:queen) { FactoryGirl.create(:queen, x_position: 1, y_position: 1, color: 'white', game: game) }
    context 'should update piece position' do
      it 'when valid move' do
        login_as(user1, scope: :user)
        pawn1.move_to!(0,3)
        expect(pawn1.y_position).to eq 3
      end
    end
    context 'should update piece position and capture' do
      it 'when valid move to enemy position' do
        login_as(user2, scope: :user)
        pawn2.move_to!(1,1)
        expect(game.pieces.find_by(x_position: 1, y_position: 1).type).to eq "Pawn"
      end
    end
    context 'should not update piece position' do
      it 'when invalid move' do
        login_as(user1, scope: :user)
        pawn1.move_to!(0,5)
        pawn2.move_to!(1,3)
        queen.move_to!(-1,1000)
        expect(pawn1.y_position).to eq 1
        expect(pawn2.y_position).to eq 2
        expect(queen.y_position).to eq 1
      end
    end
  end
end
