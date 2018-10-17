require 'rails_helper'
include SignIn

RSpec.describe Admin::UsersController, type: :controller do
  #TODO generate a password and email to the student

  describe "GET #index" do
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

  describe "Get #create" do
    context 'user not logged in' do
      it 'should be redirected to log in page' do
        post :create, params: { user: {} }
        expect(response).to redirect_to login_path
        expect(subject.request.flash[:alert]).to eq("You must be logged in")
      end
    end

    context 'user logged in' do
      it 'not authorized to make this action' do
        student = create(:user_two)
        sign_in_user(student)
        post :create, params: { user: {} }
        expect(response).to redirect_to root_path
        expect(subject.request.flash[:alert]).to eq("This operation not allowed")
      end
    end
  end

  describe "GET #create" do
    before do
      user = create(:admin_user)
      sign_in_user(user)
      @cohort = create(:cohort)
    end
    context 'as an authenticated admin' do
      it "adds a student" do
        student_user = FactoryGirl.attributes_for(:student_user)
        student_user['cohort_ids'] = @cohort.id

        expect {
          post :create, params: { user: student_user }
        }.to change(User.all, :count).by(1)

        student = User.find_by_first_name(student_user[:first_name])
        expect(subject.request.flash[:success])
          .to eq("#{student.name.capitalize} has been added")
        expect(@cohort.users).to include(student)
        expect(student.user_information['grade']).to eq('11')
        expect(student.user_information['social_media']['twitter'])
          .to eq('https://twitter.com/graymatterexp')
        expect(subject).to redirect_to(admin_users_path(user: 'student'))
      end

      it "negative result user exists" do
        create(:student_user)
        student_user = FactoryGirl.attributes_for(:student_user)
        student_user['cohort_ids'] = @cohort.id

        expect {
          post :create, params: { user: student_user }
        }.to change(User.all, :count).by(0)

        expect(subject).to redirect_to(admin_users_path(user: 'student'))
      end
    end
  end

  describe "PATCH #update" do
    before do
      @user = create(:admin_user)
      sign_in_user(@user)
      @cohort_one = create(:cohort)
      @cohort_two = create(:cohort_two)
    end

    context 'as an authenticated amdin' do
      it "updated student" do
        student_model = create(:student_user)
        student_model.cohort_ids = @cohort_one.id

        student_user = attributes_for(:student_user)
        student_user[:first_name] = 'Fake'
        student_user[:last_name] = 'Name'
        student_user[:user_information]['phone'] = '312-321-4321'
        student_user[:user_information]['social_media']['twitter'] = 'www.google.com'

        patch :update, params: { id: student_model.id, user: student_user }
        student = User.find_by_first_name(student_user[:first_name])
        expect(@cohort_one.users).to include(student)
        expect(subject.request.flash[:success])
          .to eq("#{student.name.capitalize} has been updated")
        expect(student.first_name).to eq('Fake')
        expect(student.last_name).to eq('Name')
        expect(student.user_information['social_media']['twitter'])
          .to eq('www.google.com')
        expect(subject).to redirect_to(admin_users_path(user: 'student'))
      end
    end

    context 'as an authenticated amdin' do
      it "changes a students cohort" do
        student_model = create(:student_user)
        student_model.cohort_ids = @cohort_one.id
        expect(@cohort_one.users).to include(student_model)

        student_user = attributes_for(:student_user)
        student_user['cohort_ids'] = @cohort_two.id

        patch :update, params: { id: student_model.id, user: student_user }
        student = User.find_by_first_name(student_user[:first_name])
        expect(@cohort_one.users).to_not include(student)
        expect(@cohort_two.users).to include(student)
        expect(subject.request.flash[:success])
          .to eq("#{student.name.capitalize} has been updated")
        expect(subject).to redirect_to(admin_users_path(user: 'student'))
      end
    end
  end

  describe "GET #show" do
    before do
      @user = create(:admin_user)
      sign_in_user(@user)
      @student = create(:student_user)
    end

    context 'as an authenticated amdin' do
      it "responds with JSON formatted output" do

        post :show, format: :json,
             params: { id: @student.id }

        result = JSON.parse(response.body)
        expect(response.content_type).to eq('application/json')
        expect(result["first_name"]).to eq(@student.first_name)
      end
    end
  end

  describe "PATCH #archive_student" do
    before do
      @user = create(:admin_user)
      sign_in_user(@user)
    end

    context 'as an authenticated amdin' do
      it "archive the student" do
        student = create(:student_user)

        post :archive_student, params: { id: student.id }
        student = User.last
        expect(student.archived?).to be(true)
        expect(subject.request.flash[:success])
          .to eq("#{student.name.capitalize} has been Archived")
        expect(subject).to redirect_to(admin_users_path(user: 'student'))
      end
    end

  end
end
