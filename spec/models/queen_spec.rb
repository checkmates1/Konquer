require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:queen) { FactoryGirl.create(:queen, x_position: 0, y_position: 0, game: game) }

    context 'when piece does not move' do
      it { expect(queen.valid_move?(0, 0)).to eq false }
    end

    context 'invalid destination' do
      it { expect(queen.valid_move?(9, 0)).to eq false }
    end

    context 'obstructed' do
      it 'returns false' do
        FactoryGirl.create(:queen, x_position: 5, y_position: 0, game: game)
        expect(queen.valid_move?(7, 0)).to eq false
      end
    end

    context 'valid' do
      it { expect(queen.valid_move?(1, 0)).to eq true }
      it { expect(queen.valid_move?(0, 1)).to eq true }
      it { expect(queen.valid_move?(1, 1)).to eq true }
    end
  end
end
