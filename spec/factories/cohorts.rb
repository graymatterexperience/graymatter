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
