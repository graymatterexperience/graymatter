require 'rails_helper'
include SignIn
# NOTE: this file tests the creation of a mentor

RSpec.describe Admin::UsersController, type: :controller do
  #TODO generate a password and email to the student


  describe "GET #create" do
    before do
      user = create(:admin_user)
      sign_in_user(user)
      @cohort = create(:cohort)
    end
    context 'as an authenticated admin' do
      it "adds a mentor" do
        mentor_user = FactoryGirl.attributes_for(:mentor_user)
        mentor_user['cohort_ids'] = @cohort.id

        expect {
          post :create, params: { user: mentor_user }
        }.to change(User.all, :count).by(1)

        mentor = User.find_by_first_name(mentor_user[:first_name])
        expect(subject.request.flash[:success])
          .to eq("#{mentor.name.capitalize} has been added")
        expect(@cohort.users).to include(mentor)
        expect(mentor.user_information['company']).to eq(mentor_user[:user_information][:company])
        expect(mentor.user_information['social_media']['instagram'])
          .to eq('https://www.instagram.com/graymatterexp/')
        expect(subject).to redirect_to(admin_users_path(user: 'mentor'))
      end

      xit 'mentor can belong to many cohorts' do
        # TODO add code for this
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
      it "updated mentor information" do
        mentor_model = create(:mentor_user)
        mentor_model.cohort_ids = @cohort_one.id
        mentor_user = FactoryGirl.attributes_for(:mentor_user)
        mentor_user['cohort_ids'] = @cohort_one.id

        mentor_user = attributes_for(:mentor_user)
        mentor_user[:first_name] = 'Fake'
        mentor_user[:last_name] = 'Name'
        mentor_user[:user_information]['phone'] = '312-321-4321'
        mentor_user[:user_information][:social_media][:instagram] = 'www.google.com'
        mentor_user[:user_information][:company] = 'new company name'

        patch :update, params: { id: mentor_model.id, user: mentor_user }
        mentor = User.find_by_first_name(mentor_user[:first_name])
        expect(@cohort_one.users).to include(mentor)
        expect(subject.request.flash[:success])
          .to eq("#{mentor.name.capitalize} has been updated")
        expect(mentor.first_name).to eq('Fake')
        expect(mentor.last_name).to eq('Name')
        expect(mentor.user_information['company']).to eq('new company name')
        expect(mentor.user_information['social_media']['instagram'])
          .to eq('www.google.com')
        expect(subject).to redirect_to(admin_users_path(user: 'mentor'))
      end
    end

    context 'as an authenticated amdin' do
      it "changes a students cohort" do
        mentor_model = create(:mentor_user)
        mentor_model.cohort_ids = @cohort_one.id
        expect(@cohort_one.users).to include(mentor_model)

        mentor_user = attributes_for(:mentor_user)
        mentor_user['cohort_ids'] = @cohort_two.id

        patch :update, params: { id: mentor_model.id, user: mentor_user }
        mentor = User.find_by_first_name(mentor_user[:first_name])
        expect(@cohort_one.users).to_not include(mentor)
        expect(@cohort_two.users).to include(mentor)
        expect(subject.request.flash[:success])
          .to eq("#{mentor.name.capitalize} has been updated")
        expect(subject).to redirect_to(admin_users_path(user: 'mentor'))
      end
    end
  end

  describe "GET #show" do
    before do
      @user = create(:admin_user)
      sign_in_user(@user)
      @mentor = create(:mentor_user)
    end

    context 'as an authenticated amdin' do
      it "responds with JSON formatted output" do

        post :show, format: :json,
          params: { id: @mentor.id }

        result = JSON.parse(response.body)
        expect(response.content_type).to eq('application/json')
        expect(result["first_name"]).to eq(@mentor.first_name)
      end
    end
  end

  describe "PATCH #archive_student" do
    before do
      @user = create(:admin_user)
      sign_in_user(@user)
    end

    context 'as an authenticated amdin' do
      it "archive the mentor" do
        user = create(:mentor_user)

        post :archive_student, params: { id: user.id }
        user = User.last
        expect(user.archived?).to be(true)
        expect(subject.request.flash[:success])
          .to eq("#{user.name.capitalize} has been Archived")
        expect(subject).to redirect_to(admin_users_path(user: 'mentor'))
      end
    end

  end
end
