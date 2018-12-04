class Cohort < ApplicationRecord
  validates :name, presence: true
  # TODO: delete comment
  # assemble_by was group
  has_and_belongs_to_many :users, assemble_by: 'name'
  has_many :groups
  # This brakes things
  # has_many :users, through: :groups
  store_accessor :settings, :color, :avatar
end
