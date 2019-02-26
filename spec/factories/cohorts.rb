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

FactoryBot.define do
  factory :cohort do
    name { 'Cohort One' }
    settings {}
  end

  factory :cohort_two, class: Cohort do
    name { 'Cohort Two' }
    settings {}
  end
end
