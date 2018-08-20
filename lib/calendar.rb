class Calendar < Struct.new(:view, :date, :callback)
  HEADER = %w[S M T W T F S]
  START_DAY = :sunday

  delegate :content_tag, to: :view

  def table
    content_tag :table, class: "calendar table table-bordered table-striped" do
      header + week_rows
    end
  end

  def header
    content_tag :tr do
      HEADER.map { |day| content_tag :th, day }.join.html_safe
    end
  end

  def week_rows
    weeks.map do |week|
      content_tag :tr do
        week.map { |day| day_cell(day) }.join.html_safe
      end
    end.join.html_safe
  end

  def day_cell(day)
    content_tag :td, view.capture(day, &callback), class: day_classes(day)
  end

  def day_classes(day)
    classes = []
    #events = Event.all
    #events_by_date = events.group_by(&:the_date)
    #events.each do |date|
      #date.the_date = date.the_date.to_date
    #end
    classes << "today" if day == Date.today
    classes << "not-month" if day.month != date.month
    classes << 'day-of-month'
    #classes << "event" if events_by_date[day.in_time_zone]
    classes.empty? ? nil : classes.join(" ")
  end

  def weeks
    first = date.beginning_of_month.beginning_of_week(START_DAY)
    last = date.end_of_month.end_of_week(START_DAY)
    (first..last).to_a.in_groups_of(7)
  end
end
