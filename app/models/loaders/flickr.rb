module Loaders
  class Flickr < Loaders::Base    
    def load(load_photos = false)
      FlickrEvent.delete_all
      FlickrPhoto.delete_all
      
      sets = flickr.photosets.getList :user_id => Merb::Config[:flickr_user_id]
      sets.each do |set|
        FlickrEvent.create!(:name => set.title, :external_key => set.id)
      end
    end
  end
end
