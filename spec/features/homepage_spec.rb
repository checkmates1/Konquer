require 'rails_helper'

RSpec.feature 'All games are listed on the homepage' do
  scenario 'successfully' do
    FactoryGirl.create(:game, name: 'Test Game')
    visit root_path
    expect(page).to have_css('.game')
    expect(page).to have_text('Test Game')
  end
end
