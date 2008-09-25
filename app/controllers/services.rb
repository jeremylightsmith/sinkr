class Services < Application
  def load(id)
    raise "unknown service" unless %w(flickr iphoto).include?(id)
    @service = id

    Event.delete_all ["source = ?", @service]
    Photo.delete_all ["source = ?", @service]
    
    case @service
    when "flickr"
      sets = flickr.photosets.getList :user_id => Merb::Config[:flickr_user_id]
      sets.each do |set|
        photos = flickr.photosets.getPhotos(:photoset_id => set.id).photo
        event = Event.create!(:name => set.title, :external_key => set.id, :source => 'flickr')
        photos.each do |photo|
          event.photos.create!(:name => photo.title, :external_key => photo.id, :source => 'flickr')
        end
      end
      
    when "iphoto"
    else
      raise "unknown service"
    end
    
    render
  end
end
