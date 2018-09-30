# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  first_name       :string
#  last_name        :string
#  email            :string
#  password_digest  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  role             :string
#  reset_digest     :string
#  reset_sent_at    :datetime
#  cohort_id        :integer
#  user_information :jsonb            not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'database columns' do
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:role).of_type(:string) }
    it { should have_db_column(:user_information).of_type(:jsonb) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
  end

  describe 'Association' do
    it { should have_many(:posts) }
    it { should have_and_belong_to_many(:cohorts) }
  end

  describe 'model methods' do
    let(:user) { create(:user) }

    describe 'return user tag' do
      it 'returns the user tag based on the users full name' do
        expect(user.user_tag).to eq('@test name')
      end
    end

    describe 'display users full name' do
      it 'returns the user full name' do
        expect(user.name).to eq('test name')
      end
    end

    describe '#archived?' do
      it 'expect archive to be true' do
        user.archive = true
        user.save!
        expect(user.archived?).to be(true)
      end
    end
  end

end
