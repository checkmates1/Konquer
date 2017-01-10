require 'rails_helper'

RSpec.feature 'forfeit a game' do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game, white_player: user1, black_player: user2) }

  context 'when forfeitting' do
    it 'allows user to quit' do
      FactoryGirl.create(:king, x_position: 0, y_position: 0, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 2, color: 'white', game: game)
      FactoryGirl.create(:queen, x_position: 2, y_position: 3, color: 'white', game: game)
      login_as(user1)
      visit game_path(game)
      find_link('Forfeit')
      click_link('Forfeit')
      expect('You have forfeited.').to be_present
    end
    it 'does not show forfeit if user not logged in' do
      visit game_path(game)
      expect(page).to_not have_link 'Forfeit'
    end
  end
end
