class Cohort < ApplicationRecord
  validates :name, presence: true
  has_and_belongs_to_many :users, :group => 'name'
  store_accessor :settings, :color, :avatar
end
