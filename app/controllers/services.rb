class Services < Application
  def load(id)
    raise "unknown service" unless %w(flickr iphoto).include?(id)
    source = id

    case source
    when "flickr"
      Loaders::Flickr.new.load(false)
      
    when "iphoto"
      Loaders::IphotoBridge.new.load
      
    else
      raise "unknown service"
    end

    redirect url(:events)
  end
end
