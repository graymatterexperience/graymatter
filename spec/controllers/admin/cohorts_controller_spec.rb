require 'rails_helper'
include SignIn

RSpec.describe Admin::CohortsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      user = create(:admin_user)
      sign_in_user(user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      user = create(:admin_user)
      sign_in_user(user)
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    it 'adds a cohort' do
      user = create(:admin_user)
      sign_in_user(user)
      post_params = {
        name: 'red jacks',
        settings: {
          color: 'red'
        }
      }

      expect {
        post :create, params: {cohort: post_params}
      }.to change(Cohort.all, :count).by(1)
      cohort = Cohort.first
      expect(cohort.settings['color']).to eq('red')
      expect(subject.request.flash[:success]).to eq('Your cohort has been created')
      expect(subject).to redirect_to(admin_cohorts_path)
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
        expect(subject).to redirect_to(admin_cohorts_path)
      end
    end

    context 'as an unauthorized user (logged in, not admin)' do
      it 'should be redirected to main dashboard' do
        user = create(:user_two)
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

  describe 'PATCH #update' do
    before do
      @cohort = create(:cohort)
    end

    it 'as an authorized admin updates a cohort' do
      admin_user = create(:admin_user)
      sign_in_user(admin_user)
      cohort_params = {
        name: 'new cohort name',
        color: 'green'
      }
      patch :update, params: { id: @cohort.id, cohort: cohort_params }
      updated_cohort = Cohort.find_by_id(@cohort.id)
      expect(updated_cohort.name).to eq('new cohort name')
      expect(updated_cohort.settings['color']).to eq('green')
      expect(subject.request.flash[:success]).to eq('Cohort updated')
      expect(subject).to redirect_to(admin_cohorts_path)
    end
  end
end
