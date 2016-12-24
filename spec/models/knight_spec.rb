require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe '.valid_move?' do
    let(:game) { FactoryGirl.create(:game) }
    let(:knight) { FactoryGirl.create(:knight, x_position: 1, y_position: 0, game: game) }

    context 'when not valid destination' do
      it { expect(knight.valid_move?(3, 4)).to eq false }
    end

    context 'when valid' do
      it { expect(knight.valid_move?(3, 1)).to eq true }
    end
  end
end
