module Dated
  MONTHS = %w(January February March April May June July August September October November December)

  def month
    date.month if date
  end

  def year_month
    "#{date.year}-#{date.month}" if date
  end

  def month_name
    MONTHS[date.month - 1] if date
  end

  def year
    date.year if date
  end

  private
  def guess_year(year)
    if year < 0
      raise "invalid year"
    elsif year < 61
      2000 + year
    elsif year < 100
      1900 + year
    else
      year
    end
  end
end