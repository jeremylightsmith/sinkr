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
  
  def reload(id)
    event = Event.find(id)
    event.load_photos
    
    render_photos_for event
  end
  
  def expand(id)
    event ||= Event.find(id)
    event.load_photos unless event.loaded?
    
    render_photos_for event
  end
  
  private
  def render_photos_for(event)
    @show_pictures = true
    render partial("event", :with => event), :layout => false
  end
end
