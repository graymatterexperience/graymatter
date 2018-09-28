class Cohort < ApplicationRecord
  validates :name, presence: true
  has_and_belongs_to_many :users
  store_accessor :settings, :color, :avatar
end
