module Merb
  module DashboardHelper
    def get_id
      user = flickr.people.findByUsername :username => "Jeremy Lightsmith"
      "#{user.username} - #{user.nsid}"
    end
    
    def photosets
      flickr.photosets.getList :user_id => Merb::Config[:flickr_user_id]
    end
  end
end