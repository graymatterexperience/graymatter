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
mentor_information = {
  avatar: 'User_Avatar_2.png',
  phone: Faker::PhoneNumber.phone_number,
  company: Faker::Company.name,
  specialty: Faker::Company.industry,
  company_logo: Faker::Company.logo,
  social_media: {
    instagram: 'https://www.instagram.com/graymatterexp/'
  }
}

user_information = {
  'avatar' => 'fake_image.jpg',
  'phone' => Faker::PhoneNumber.phone_number,
  'school' => 'West Highschool',
  'grade' => '11',
  'social_media' => {
    'instagram' => 'https://www.instagram.com/graymatterexp/',
    'linkedin' => 'https://www.linkedin.com/company/the-gray-matter-experience/',
    'twitter' => 'https://twitter.com/graymatterexp',
    'facebook' => 'https://www.facebook.com/GrayMatterExp/'
  }
}

  factory :user do
    first_name 'test'
    last_name 'name'
    email 'test@email.com'
    password 'password'
  end

  # TODO deprecated remove from tests DO NOT use
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

  factory :student_user, class: User do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    password 'password'
    role 'student'
    user_information user_information
  end

  factory :mentor_user, class: User do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    password 'password'
    role 'mentor'
    user_information mentor_information
  end
end

