module ApplicationHelper
  def minutes_to_human(time_in_minutes)
    if time_in_minutes < 60
      t('.time_in_minutes', minutes: time_in_minutes)
    else
      t('.time_in_hours', hours: (time_in_minutes / 60.0).round(2))
    end
  end
end
