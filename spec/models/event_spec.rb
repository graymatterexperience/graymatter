# == Schema Information
#
# Table name: events
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  description :text
#  start       :datetime
#  end         :datetime
#  all_day     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color       :string
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'The database' do
    xit { should have_db_column(:title).of_type(:string) }
    xit { should have_db_column(:description).of_type(:text) }
    xit { should have_db_column(:start_time).of_type(:datetime) }
    xit { should have_db_column(:end_time).of_type(:datetime) }
    xit { should have_db_column(:all_day).of_type(:boolean) }
  end

  describe 'Validations' do
    xit { should validate_presence_of(:title) }
  end
end
