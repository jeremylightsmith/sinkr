module Dated
  MONTHS = %w(January February March April May June July August September October November December)
  
  def date=(date)
    date = Date.parse(date) if date.is_a?(String)
    self[:date] = date
  end

  def month
    date.month if date
  end
  
  def year
    date.year if date
  end

  def year_month
    date.strftime("%Y-%m") if date
  end

  def month_name
    MONTHS[date.month - 1] if date
  end
end