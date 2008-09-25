module Merb
  module DashboardHelper
    def get_id
      user = flickr.people.findByUsername :username => "Jeremy Lightsmith"
      "#{user.username} - #{user.nsid}"
    end
  end
end