# == Schema Information
#
# Table name: events
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  description :text
#  start_time  :datetime
#  end_time    :datetime
#  all_day     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :event do
    title "Event title"
    description "Event description"
    start "2018-08-20 13:16:16"
    #end "2018-08-20 13:16:16"
    all_day false
  end
end
