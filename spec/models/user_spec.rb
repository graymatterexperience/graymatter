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
    it { should have_db_column(:cohort_id).of_type(:integer) }
    it { should have_db_column(:user_information).of_type(:jsonb) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    context 'cohort_id Validations based on users role' do
      it 'expect positive, cohort_id to be preset, user IS student' do
        create(:cohort)
        student = User.new(
          first_name: 'Aaron',
          last_name: 'Summer',
          email: 'aaron@email.com',
          password: 'password',
          role: 'student',
          cohort_id: 1
        )
        expect(student).to be_valid
      end

      it 'expect negative result, cohort_id to be preset, user IS student' do
        create(:cohort)
        student = User.new(
          first_name: 'Aaron',
          last_name: 'Summer',
          email: 'aaron@email.com',
          password: 'password',
          role: 'student'
        )
        expect(student).to_not be_valid
      end

      it 'expect negative, cohort_id to be preset, user NOT admin' do
        student = User.new(
          first_name: 'Aaron',
          last_name: 'Summer',
          email: 'aaron@email.com',
          password: 'password',
          role: 'mentor'
        )
        expect(student).to be_valid
      end

      it 'expect postive, cohort_id not expected, user IS admin' do
        student = User.new(
          first_name: 'Aaron',
          last_name: 'Summer',
          email: 'aaron@email.com',
          password: 'password',
          role: 'admin'
        )
        expect(student).to be_valid
      end
    end
  end

  describe 'Association' do
    it { should have_many(:posts) }
    it { should have_and_belong_to_many(:cohorts) }
  end

  describe 'model methods' do
    let(:cohort) { create(:cohort) }
    let(:user) { create(:user, cohort_id: cohort.id) }

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
  end

end
