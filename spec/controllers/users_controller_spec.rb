require 'rails_helper'
include SignIn

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    let(:admin_user) { create(:admin_user) }
    before do
      sign_in_user(admin_user)
    end
    xit "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
