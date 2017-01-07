require 'rails_helper'

RSpec.feature 'join a game' do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game, white_player_id: user1.id) }

  context 'when available' do
    it 'allows user to join' do
      login_as(user2, scope: :user)
      visit game_path(game)

      find_link('Join Game')
      click_link('Join Game')

      expect(game.reload.black_player_id).to eq user2.id
    end
  end
end
