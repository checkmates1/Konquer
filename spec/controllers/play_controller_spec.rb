require 'rails_helper'

RSpec.describe PlayController, type: :controller do
  describe 'play#index action' do
    it 'should successfully display the homepage' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
