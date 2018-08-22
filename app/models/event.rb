class Event < ApplicationRecord
  validates_presence_of :title

  def the_date
    Date.parse(start_time.to_s)
  end
end
