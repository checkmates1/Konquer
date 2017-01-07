require 'rails_helper'

RSpec.feature 'forfeit a game' do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game, white_player: user1, black_player: user2) }

  context 'when forfeitting' do
    it 'allows user to quit' do
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
