class Sources < Application
  def index
    render
  end
  
  def reload(id)
    event = ExternalEvent.find(id)
    event.load_photos
    
    render_photos_for event
  end
  
  def expand(event_id, id)
    event ||= ExternalEvent.find(id)
    event.load_photos unless event.loaded?
    
    render_photos_for event
  end
  
  def reload_all_events(id)
    find_type(id).reload_all
    redirect url(:events)
  end
  
  def load_all_photos(id)
    find_type(id).each do |external_event|
      external_event.load_photos unless external_event.loaded?
    end
    redirect url(:events)
  end
  
  private
  def find_type(id)
    case id.to_sym
    when :flickr then FlickrEvent
    when :iphoto then IphotoEvent
    else
      raise "expected flickr or iphoto and got #{id}"
    end
  end

  def render_photos_for(event)
    @show_pictures = true
    render partial("events/external_event", :with => event), :layout => false
  end
end
