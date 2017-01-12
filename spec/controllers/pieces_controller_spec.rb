require 'rails_helper'
RSpec.describe PiecesController, type: :controller do
  before do
    allow_any_instance_of(Game).to receive(:populate_board!).and_return true
  end

  describe 'assign_active_player' do
    let(:black_player) { FactoryGirl.create(:user) }
    let(:game) { FactoryGirl.create(:game, black_player: black_player) }
    let(:white_pawn) { FactoryGirl.create(:pawn, color: 'white', type: 'Pawn', game: game, x_position: 0, y_position: 0) }
    it 'should change active_player from white_player to black_player' do
      game.active_player = game.white_player
      put :update, params: { id: white_pawn.id, piece: { x_position: 0, y_position: 1 } }

      expect(game.reload.active_player).to eq game.black_player
    end
  end
end
