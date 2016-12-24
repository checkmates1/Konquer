require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:knight) { FactoryGirl.create(:knight, x_position: 4, y_position: 4, game: game) }

    context 'move is invalid' do
      it { expect(knight.valid_move?(6, 6)).to eq false }
      it { expect(knight.valid_move?(2, 7)).to eq false }
      it { expect(knight.valid_move?(5, 3)).to eq false }
      it { expect(knight.valid_move?(2, 7)).to eq false }
      it { expect(knight.valid_move?(2, 6)).to eq false }
      it { expect(knight.valid_move?(3, 3)).to eq false }
      it { expect(knight.valid_move?(0, 0)).to eq false }
      it { expect(knight.valid_move?(4, 4)).to eq false }
    end

    context 'move is valid' do
      it { expect(knight.valid_move?(6, 5)).to eq true }
      it { expect(knight.valid_move?(2, 3)).to eq true }
      it { expect(knight.valid_move?(5, 6)).to eq true }
      it { expect(knight.valid_move?(3, 2)).to eq true }
      it { expect(knight.valid_move?(2, 5)).to eq true }
      it { expect(knight.valid_move?(3, 6)).to eq true }
      it { expect(knight.valid_move?(5, 2)).to eq true }
      it { expect(knight.valid_move?(6, 3)).to eq true }
    end
  end
end
