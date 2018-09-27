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

class Event < ApplicationRecord
  validates_presence_of :title
  scope :testing, -> { where(color: 'black' ) }

  def the_date
    Date.parse(start.to_s)
  end

  def event_this_month?
    start.month == Date.today.month
  end
end
