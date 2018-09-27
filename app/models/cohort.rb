class Cohort < ApplicationRecord
  validates :name, presence: true
  has_many :users
  store_accessor :settings, :color, :avatar
end
