module ApplicationHelper

  def format_date(date)
    date.strftime("%b %d, %Y")
  end

  def format_timestamp(date)
    date.strftime('%m-%d-%Y %H:%M')
  end
end
