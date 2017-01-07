require 'rails_helper'

RSpec.feature 'All games are listed on the homepage' do
  let(:user1) { FactoryGirl.create(:user) }
  scenario 'successfully' do
    FactoryGirl.create(:game, name: 'Test Game')
    login_as(user1, scope: :user)
    visit root_path
    expect(page).to have_css('.game')
    expect(page).to have_text('Test Game')
  end
end
