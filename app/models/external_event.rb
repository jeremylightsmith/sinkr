class ExternalEvent < ActiveRecord::Base
  belongs_to :event
  before_save :attach_to_event
  
  def event_element
    "$('#event_#{event_id}')"
  end
  
  private 

  def attach_to_event
    name, date = split_name
    
    if event
      if event.name == name && event.date == date
        return
      elsif event.external_events == [self]
        event.external_events.clear
        event.destroy
      end
    end
        
    event = Event.find(:first, :conditions => ["name = ? and date = ?", name, date])
    event ||= Event.create!(:name => name, :date => date)
    self.event = event
  end
  
  # split name into name & date parts - date may be nil
  def split_name
    if name.to_s =~ /^(.+)\((\d+)\\?[\/|\:](\d+)\)$/
      [$1.strip, Date.parse("#{$2}/1/#{guess_year($3.to_i)}")]
    else
      [name, nil]
    end
  rescue
    puts "couldn't parse #{name}"
    raise
  end
  
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