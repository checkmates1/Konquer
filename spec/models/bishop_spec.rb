require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:bishop) { FactoryGirl.create(:bishop, x_position: 2, y_position: 0, game: game) }

    context 'when valid and unobstructed move' do
      it { expect(bishop.valid_move?(5, 3)).to eq true }
    end

    context 'when obstructed' do
      it 'returns false' do
        FactoryGirl.create(:bishop, x_position: 4, y_position: 2, game: game)
        expect(bishop.valid_move?(5, 3)).to eq false
      end
    end

    context 'when invalid direction' do
      it { expect(bishop.valid_move?(0, 0)).to eq false }
    end

    context 'when destination out of bounds' do
      it { expect(bishop.valid_move?(8, 6)).to eq false }
    end
  end
end
