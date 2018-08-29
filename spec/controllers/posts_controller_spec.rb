# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  body       :text
#  auther_id  :integer          not null
#  user_tags  :string           is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    #TODO need to figure out the name thing I can not use first_name... what if there
    #are lots of pople named kim
    describe 'creates a new post' do
      before do
        create(:user)
        create(:user_two)
      end
      let(:user) { User.find_by_first_name('test') }
      let(:user2) { User.find_by_first_name('kim') }

      it 'adds a post' do
        post_params = attributes_for(:post)

        expect {
          post :create, params: { post: post_params }
        }.to change(user.posts, :count).by(1)
        expect(subject.request.flash[:success]).to eq('Successfully created a question')
        expect(subject).to redirect_to( posts_path )
      end

      it 'adds a post error' do
        post_params = attributes_for(:post)
        post_params[:auther_id] = nil

        expect {
          post :create, params: { post: post_params }
        }.to change(user.posts, :count).by(0)
        expect(subject.request.flash[:error]).to eq('Something went wrong try again')
        expect(subject).to render_template( :new )
      end

      it 'finds the user tag in the body' do
        post_params = attributes_for(:post)
        post_params[:auther_id] = user.id

        post :create, params: { post: post_params }
        test_user = User.first
        expect(test_user.posts.first.user_tags.length).to be(1)
        expect(test_user.posts.first.user_tags.first).to eq(user2.user_tag)
      end

      it 'finds multi tags in the body' do
        post_params = attributes_for(:post)
        post_params[:body] = 'this @kim penball is test with two users taged @test name'
        expected_result = ['@test name', '@kim penball']
        post_params[:auther_id] = user.id

        post :create, params: { post: post_params }
        test_user = User.first
        expect(test_user.posts.first.user_tags).to match(expected_result)
      end

    end
  end

end
