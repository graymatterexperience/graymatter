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
    it { should have_many(:users) }
  end
end
