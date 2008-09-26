class Services < Application
  def load(id)
    raise "unknown service" unless %w(flickr iphoto).include?(id)
    source = id

    Event.delete_all ["source = ?", source]
    Photo.delete_all ["source = ?", source]
    
    case source
    when "flickr"
      sets = flickr.photosets.getList :user_id => Merb::Config[:flickr_user_id]
      sets.each do |set|
        Event.create!(:name => set.title, :external_key => set.id, :source => source)
      end
      
    when "iphoto"
      iphoto = Iphoto.new
      iphoto.years.each do |year|
        year.events.each do |iphoto_event|
          event = Event.create!(:name => iphoto_event.name, :external_key => iphoto_event.path, :source => source)
          iphoto_event.photos.each do |iphoto_photo|
            event.photos.create!(:name => iphoto_photo.name, 
                                 :external_key => iphoto_photo.path, 
                                 :source => source,
                                 :date => iphoto_photo.date)
          end
          event.date = event.photos.map {|p| p.date}.min
          event.save!
        end
      end
      
    else
      raise "unknown service"
    end

    redirect url(:events)
  end
end
