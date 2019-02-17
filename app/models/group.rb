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

# TODO: delete user_id from group

class Group < ApplicationRecord
  has_many :users, dependent: :delete_all
  belongs_to :cohort
end
