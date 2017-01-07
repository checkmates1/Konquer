require 'rails_helper'

RSpec.describe King, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:king) { FactoryGirl.create(:king, x_position: 4, y_position: 0, game: game) }

    context 'when valid' do
      it { expect(king.valid_move?(4, 1)).to eq true }
      it { expect(king.valid_move?(5, 0)).to eq true }
      it { expect(king.valid_move?(3, 0)).to eq true }
      it { expect(king.valid_move?(5, 0)).to eq true }
      it { expect(king.valid_move?(5, 1)).to eq true }
      it { expect(king.valid_move?(3, 1)).to eq true }
    end

    context 'when move is more than one space' do
      it { expect(king.valid_move?(4, 2)).to eq false }
      it { expect(king.valid_move?(6, 2)).to eq false }
    end

    context 'when not valid destination' do
      it { expect(king.valid_move?(4, -1)).to eq false }
    end

    context 'when obstructed' do
      it 'returns false' do
        FactoryGirl.create(:king, x_position: 3, y_position: 0, game: game)
        expect(king.valid_move?(4, 0)).to eq false
      end
    end
  end
end
