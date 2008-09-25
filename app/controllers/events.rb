class Events < Application
  def index(source = nil)
    filter = {}
    filter[:conditions] = ["source = ?", source] if source
    
    @events = Event.find(:all, filter)
    render
  end
  
  def show(id)
    @event = Event.find(id)
    render
  end
end
