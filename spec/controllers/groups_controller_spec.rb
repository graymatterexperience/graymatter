require 'rails_helper'
include SignIn

RSpec.describe GroupsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      user = create(:admin_user)
      sign_in_user(user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
