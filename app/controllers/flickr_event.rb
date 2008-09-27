class FlickrEvent < Event
  def ensure_photos_loaded
    return if loaded?
    
    photoset = flickr.photosets.getPhotos(:photoset_id => external_key,
                                        :extras => "date_taken, icon_server").photo
    photoset.each do |photo|
      photos << FlickrPhoto.create!(:event_id => id, 
                                    :name => photo.title, 
                                    :date => photo.datetaken,
                                    :flickr_id => photo.id,
                                    :server => photo.server,
                                    :secret => photo.secret,
                                    :farm => photo.farm)
    end
  end
end