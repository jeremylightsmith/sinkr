class Events < Application  
  def index
    @events_by_month_by_year = {}
    @unsorted_events = []
    Event.find(:all).each do |event|
      if event.date
        ((@events_by_month_by_year[event.year] ||= {})[event.month] ||= []) << event
      else
        @unsorted_events << event
      end
    end
    
    render
  end
  
  def show(id)
    @event = Event.find(id)
    render
  end
end
