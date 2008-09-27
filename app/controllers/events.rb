class Events < Application  
  def index(source = nil)
    filter = {:order => 'date'}
    filter[:conditions] = ["source = ?", source] if source

    @events_by_month_by_year = {}
    @unsorted_events = []
    Event.find(:all, filter).each do |event|
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
  
  def refresh(id)
    event = Event.find(id)
    event.photos.destroy_all
    photos = flickr.photosets.getPhotos(:photoset_id => event.external_key).photo
    photos.each do |photo|
      event.photos.create!(:name => photo.title, :external_key => photo.id, :source => 'flickr')
    end
    
    render partial("event", :with => event), :layout => false
  end
  
  def expand(id)
    event = Event.find(id)
    @show_pictures = true
    render partial("event", :with => event), :layout => false
  end
end
