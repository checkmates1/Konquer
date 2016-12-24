require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:pawn) { FactoryGirl.create(:pawn, x_position: 4, y_position: 2, game: game) }

    context 'when valid' do
      it { expect(pawn.valid_move?(4, 3)).to eq true }
    end

    context 'when move is backwards' do
      it { expect(pawn.valid_move?(4, 1)).to eq false }
    end

    context 'when move is diagonal' do
      it { expect(pawn.valid_move?(5, 3)).to eq false }
    end

    context 'when move is more than 1' do
      it { expect(pawn.valid_move?(4, 4)).to eq false }
    end

    context 'when not valid destination' do
      it { expect(pawn.valid_move?(9, 0)).to eq false }
    end
    # Need to test that it is an enemy
    context 'when obstructed' do
      it 'returns true' do
        FactoryGirl.create(:pawn, x_position: 4, y_position: 3, game: game)
        expect(pawn.valid_move?(4, 3)).to eq true
      end
    end
  end
end
