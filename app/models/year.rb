class Year
  include Comparable
  
  def initialize(year)
    @year = year
  end
  
  def events
    @events ||= Event.find(:all, :conditions => ["year = ?", @year])
  end
  
  def photos
    @photos ||= Photo.find(:all, :conditions => ["year = ?", @year])
  end
  
  def to_i
    @year.to_i
  end
  
  def to_s
    @year.to_s
  end
  
  def <=>(other)
    to_i <=> other.to_i
  end
  
  def all
    Event.connection.select_all("select year from events group by year").values.map {|value| Year.new(value)}.sort
  end
end
