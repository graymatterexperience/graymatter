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

FactoryBot.define do
  factory :user do
    first_name 'test'
    last_name 'name'
    email 'test@email.com'
    password 'password'
  end

  factory :user_two, class: User do
    first_name 'kim'
    last_name 'penball'
    email 'penball@email.com'
    password 'password'
    role 'student'
  end

  factory :admin_user, class: User do
    first_name 'jess'
    last_name 'roller'
    email 'jess@email.com'
    password 'password'
    role 'admin'
  end
end
