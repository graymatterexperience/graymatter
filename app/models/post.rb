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

class Post < ApplicationRecord
  belongs_to :auther,
             class_name: 'User', 
             foreign_key: :auther_id,
             primary_key: :id

  validates :body, presence: true
end
