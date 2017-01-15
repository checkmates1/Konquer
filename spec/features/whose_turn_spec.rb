require 'rails_helper'

RSpec.feature 'Show whose turn on the game page' do
  let(:user_black) { FactoryGirl.create(:user) }
  let(:user_white) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game, black_player: user_black, white_player: user_white, active_player: user_black) }
  scenario 'if current_user is black_player and active_player is black' do
    login_as(user_black, scope: :user)
    visit game_path(game)
    expect(page).to have_text('Your turn!')
  end
  scenario 'if current_user is white_player and active_player is black' do
    login_as(user_white, scope: :user)
    visit game_path(game)
    expect(page).to have_text('Not your turn yet.')
  end
end
