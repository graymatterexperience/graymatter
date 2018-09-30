require 'rails_helper'
include SignIn

RSpec.describe StudentsController, type: :controller do

  describe "GET #index" do
    let(:admin_user) { create(:admin_user) }
    before do
      sign_in_user(admin_user)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
