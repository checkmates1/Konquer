require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '.check?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:king) { FactoryGirl.create(:king, x_position: 3, y_position: 0, game: game, color: 'white') }

    context 'when in check' do
      it 'returns false' do
        FactoryGirl.create(:pawn, x_position: 3, y_position: 1, game: game, color: 'black')
        expect(game.check?).to eq true
      end
    end

    context 'when not in check' do
      it 'returns false' do
        FactoryGirl.create(:pawn, x_position: 4, y_position: 4, game: game, color: 'black')
        expect(game.check?).to eq false
      end
    end
  end
end
