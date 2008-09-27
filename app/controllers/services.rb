class Services < Application
  def load(id)
    raise "unknown service" unless %w(flickr iphoto).include?(id)
    source = id

    case source
    when "flickr"
      FlickrEvent.reload_all
      
    when "iphoto"
      IphotoEvent.reload_all
      
    else
      raise "unknown service"
    end

    redirect url(:events)
  end
end
