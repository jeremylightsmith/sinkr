class Event < ActiveRecord::Base
  include Dated
  has_many :external_events
  
  def flickr
    external_events.find_by_type(FlickrEvent.to_s)
  end
  
  def iphoto
    external_events.find_by_type(IphotoEvent.to_s)
  end
end
