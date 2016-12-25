require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:pawn) { FactoryGirl.create(:pawn, x_position: 4, y_position: 2, color: 'white', game: game) }

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
    
    context 'when obstructed' do
      it 'returns true' do
        FactoryGirl.create(:pawn, x_position: 4, y_position: 3, color: 'white', game: game)
        expect(pawn.valid_move?(5, 3)).to eq false
      end
    end
  end
end
RSpec.describe Pawn, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:pawn) { FactoryGirl.create(:pawn, x_position: 4, y_position: 6, color: 'black', game: game) }

    context 'when valid for black' do
      it { expect(pawn.valid_move?(4, 4)).to eq true }
      it { expect(pawn.valid_move?(4, 5)).to eq true }
      it { expect(pawn.valid_move?(4, 7)).to eq false }
    end
  end
end