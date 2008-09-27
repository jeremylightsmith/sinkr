class FlickrPhoto < Photo
  def thumbnail_url
    "http://farm#{farm}.static.flickr.com/#{server}/#{flickr_id}_#{secret}_s.jpg"
  end
  
  def url
    "http://farm#{farm}.static.flickr.com/#{server}/#{flickr_id}_#{secret}.jpg"
  end
end