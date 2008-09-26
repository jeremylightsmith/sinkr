class Photos < Application
  def index
    render
  end

  def refresh(event_id)
    event = Event.find(event_id)
    event.photos.destroy_all
    photos = flickr.photosets.getPhotos(:photoset_id => event.external_key).photo
    photos.each do |photo|
      event.photos.create!(:name => photo.title, :external_key => photo.id, :source => 'flickr')
    end
    
    render partial("events/event", :with => event)
  end
end
