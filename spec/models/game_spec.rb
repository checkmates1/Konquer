require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '.check?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:king) { FactoryGirl.create(:king, x_position: 3, y_position: 0, color: 'white', game: game) }

    context 'when in check' do
      it 'should return true' do
        FactoryGirl.create(:pawn, x_position: 3, y_position: 1, color: 'black', game: game)
        expect(game.check?).to eq true
      end
    end

    context 'when not in check' do
      it 'should return false' do
        FactoryGirl.create(:pawn, x_position: 4, y_position: 4, color: 'black', game: game)
        expect(game.check?).to eq false
      end
    end
  end
end
