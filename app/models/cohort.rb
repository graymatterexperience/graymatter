# == Schema Information
#
# Table name: cohorts
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  settings   :jsonb
#

class Cohort < ApplicationRecord
  validates :name, presence: true
  # TODO: delete comment
  # assemble_by was group
  has_and_belongs_to_many :users, assemble_by: 'name'
  has_many :groups
  # This brakes things
  # has_many :users, through: :groups
  store_accessor :settings, :color, :avatar
  before_save :downcase_name

  private

  def downcase_name
    self.name = name.downcase
  end
end
