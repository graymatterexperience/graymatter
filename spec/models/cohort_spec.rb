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

require 'rails_helper'

RSpec.describe Cohort, type: :model do
  describe 'database columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:settings).of_type(:jsonb) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Association' do
    it { should have_and_belong_to_many(:users) }
  end
end
