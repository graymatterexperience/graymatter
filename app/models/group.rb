# == Schema Information
#
# Table name: groups
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  user_id    :bigint(8)
#  cohort_id  :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_many :users
  belongs_to :cohort
end
