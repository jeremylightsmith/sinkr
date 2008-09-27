class FlickrEvent < Event
  def load_photos
    photos.delete_all

    photoset = flickr.photosets.getPhotos(:photoset_id => external_key,
                                          :extras => "date_taken, icon_server").photo
    photoset.each do |photo|
      photos << FlickrPhoto.create!(:event_id => id, 
                                    :name => photo.title, 
                                    :date => photo.datetaken,
                                    :flickr_id => photo.id.to_i,
                                    :server => photo.server,
                                    :secret => photo.secret,
                                    :farm => photo.farm)
    end
    update_attribute(:loaded, true)
  end
  
  def self.reload_all
    FlickrEvent.delete_all
    FlickrPhoto.delete_all
    
    sets = flickr.photosets.getList :user_id => Merb::Config[:flickr_user_id]
    sets.each do |set|
      event = new(:name => set.title, :external_key => set.id)
      event.collection = event.year ? event.year : "other"
      event.save!
    end
  end
end