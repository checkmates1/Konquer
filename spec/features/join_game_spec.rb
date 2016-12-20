require 'rails_helper'

RSpec.feature 'Joining a game' do
  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let(:game) {FactoryGirl.create(:game, white_player_id: user1)}

  it 'join open game' do
    login_as(user2, :scope => :user)

    visit game_path(game)
    #expect(page).to have_text('Only one more player needed!')
    find_link('Join Game', :visible => :all).visible?

    click_link('Join Game')
    #expect(response).to redirect_to game_path(game)

    game.reload
    expect(game.black_player_id).to eq user2.id

  end


end
