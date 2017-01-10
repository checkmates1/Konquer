require 'rails_helper'

RSpec.feature 'stalemate' do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game, white_player_id: user1.id, black_player_id: user2.id) }

  context 'when in stalemate' do
    it 'should end game in draw and alert the players' do
      login_as(user2, scope: :user)
      visit game_path(game)
      FactoryGirl.create(:king, x_position: 0, y_position: 0, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 2, y_position: 1, color: 'white', game: game)
      FactoryGirl.create(:queen, x_position: 1, y_position: 2, color: 'white', game: game)

      game.reload
      game.stalemate?
      expect('Stalemate. Game ends in a Draw').to be_present
    end
  end

  context 'when not in stalemate' do
    it 'should do nothing' do
      login_as(user1, scope: :user)
      visit game_path(game)
      FactoryGirl.create(:king, x_position: 0, y_position: 0, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 2, color: 'white', game: game)
      FactoryGirl.create(:queen, x_position: 2, y_position: 3, color: 'white', game: game)

      game.stalemate?
      expect(page).to_not have_content 'Stalemate. Game ends in a Draw'
    end
  end
end
