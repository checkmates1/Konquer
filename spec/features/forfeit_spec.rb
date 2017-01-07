require 'rails_helper'

RSpec.feature 'forfeit a game' do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game, white_player: user1, black_player: user2) }

  context 'when available' do
    it 'allows user to quit' do
      visit game_path(game)
      find_link('Forfeit')
      click_link('Forfeit')
      expect('You have forfeited.').to be_present
    end
  end
end
