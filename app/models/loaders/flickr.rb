module Loaders
  class Flickr < Loaders::Base
    def source
      "flickr"
    end
    
    def load(load_photos = false)
      clear_events
      
      sets = flickr.photosets.getList :user_id => Merb::Config[:flickr_user_id]
      sets.each do |set|
        Event.create!(:name => set.title, :external_key => set.id, :source => source)
      end
    end
  end
end
