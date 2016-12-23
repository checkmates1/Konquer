require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:rook) { FactoryGirl.create(:rook, x_position: 0, y_position: 0, game: game) }

    context 'when not valid direction' do
      it { expect(rook.valid_move?(5, 4)).to eq false }
    end

    context 'when not valid destination' do
      it { expect(rook.valid_move?(9, 0)).to eq false }
    end

    context 'when obstructed' do
      it 'returns false' do
        FactoryGirl.create(:rook, x_position: 5, y_position: 0, game: game)
        expect(rook.valid_move?(7, 0)).to eq false
      end
    end

    context 'when valid' do
      it { expect(rook.valid_move?(5, 0)).to eq true }
    end
  end
end
