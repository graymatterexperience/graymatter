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

RSpec.describe Post, type: :model do
  describe "database columns" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:body).of_type(:text) }
    it { should have_db_column(:auther_id).of_type(:integer) }
    it { should have_db_column(:user_tags).of_type(:string) }
  end

  describe 'Validations' do
    it 'expect a positive result' do
      user = create(:user)
      expect(Post.new(title: 'Test title',
                      body: 'this is the test body',
                      user_tags: ['@user1'],
                      auther_id: user.id)).to be_valid
    end

    it 'expect a negative result' do
      expect(Post.new(title: 'Test title',
                      body: 'this is the test body',
                      auther_id: nil,
                      user_tags: [])).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:auther) }
    #it { should have_many(:comments) }
  end
end
