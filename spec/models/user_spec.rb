# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :string
#  reset_digest    :string
#  reset_sent_at   :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts) }

  describe 'display user tag' do
    let(:user) { create(:user) }
    it 'returns the user tag based on the user full name' do
      expect(user.user_tag).to eq('@test name')
    end
  end
end
