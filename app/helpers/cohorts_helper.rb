module CohortsHelper
  def display_cohort_names(user)
    cohorts = user.cohorts.pluck(:name)
    if cohorts.any?
      cohorts.collect { |cohort| content_tag(:li, cohort, class: 'mdl-menu__item') }.join.html_safe
    else
      content_tag(:span, 'All Cohorts', class: 'cohort-name-container')
    end
  end
end
