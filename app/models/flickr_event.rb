class FlickrEvent < ExternalEvent
  has_many :photos, 
           :class_name => 'FlickrPhoto', 
           :foreign_key => 'external_event_id', 
           :dependent => :destroy,
           :order => 'name'

  def element
    "$('#flickr_event_#{id}')"
  end

  def load_photos
    photos.destroy_all

    photoset = flickr.photosets.getPhotos(:photoset_id => flickr_id,
                                          :extras => "date_taken, icon_server").photo
    photoset.each do |photo|
      photos << FlickrPhoto.create!(:external_event_id => id, 
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
      create!(:name => set.title, :flickr_id => set.id)
    end
  end
end