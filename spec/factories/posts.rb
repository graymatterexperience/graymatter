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

FactoryBot.define do
  factory :post do
    title "Test Post"
    body "This is the body to the test. @kim penball"
    auther_id 1
    user_tags []
  end
end
