require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '.check?' do
    let(:game) { FactoryGirl.create(:game) }

    it 'should return true' do
      FactoryGirl.create(:pawn, x_position: 4, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 3, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 2, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 3, y_position: 1, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 0, color: 'white', game: game)
      expect(game.check?).to eq true
    end
    let(:game) { FactoryGirl.create(:game) }

    it 'should return false' do
      FactoryGirl.create(:pawn, x_position: 4, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 3, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 2, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 0, color: 'white', game: game)
      expect(game.check?).to eq false
    end
  end

  describe '.check_mate?' do
    let(:game) { FactoryGirl.create(:game) }

    it 'should return false' do
      FactoryGirl.create(:rook, x_position: 2, y_position: 1, color: 'white', game: game)
      FactoryGirl.create(:queen, x_position: 3, y_position: 1, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 0, color: 'white', game: game)
      expect(game.check_mate?).to eq false
    end
    let(:game) { FactoryGirl.create(:game) }

    it 'should return true' do
      FactoryGirl.create(:rook, x_position: 0, y_position: 1, color: 'black', game: game)
      FactoryGirl.create(:queen, x_position: 3, y_position: 4, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 0, color: 'white', game: game)
      expect(game.check_mate?).to eq true
    end
  end
end
