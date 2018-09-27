require 'rails_helper'
include SignIn

RSpec.describe Admin::CohortsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    it 'adds a cohort' do
      post_params = attributes_for(:cohort)
      post_params[:settings] = {
        color: 'red'
      }

      expect {
        post :create, params: {cohort: post_params}
      }.to change(Cohort.all, :count).by(1)
      cohort = Cohort.first
      expect(cohort.settings['color']).to eq('red')
      expect(subject.request.flash[:success]).to eq('Your cohort has been created')
      expect(subject).to redirect_to(home_path)
    end
  end

  describe 'GET #destroy' do
    before do
      @cohort = create(:cohort)
    end

    context 'as an authorized user' do
      it 'as an authorized admin removes a cohort' do
        admin_user = create(:admin_user)
        sign_in_user(admin_user)
        expect {
          delete :destroy, params: { id: @cohort.id }
        }.to change(Cohort.all, :count).by(-1)
        expect(subject.request.flash[:success]).to eq('Cohort removed')
      end
    end

    context 'as an unauthorized user (logged in, not admin)' do
      it 'should be redirected to main dashboard' do
        user = create(:user_two, cohort_id: @cohort.id)
        sign_in_user(user)
        delete :destroy, params: { id: @cohort.id }
        expect(response).to redirect_to root_path
        expect(subject.request.flash[:alert]).to eq("This operation not allowed")
      end
    end

    context 'user not logged in' do
      it 'should be redirected to main dashboard' do
        delete :destroy, params: { id: @cohort.id }
        expect(response).to redirect_to login_path
        expect(subject.request.flash[:alert]).to eq("You must be logged in")
      end
    end
  end

end
