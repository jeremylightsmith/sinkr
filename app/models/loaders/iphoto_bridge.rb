module Loaders
  class IphotoBridge < Loaders::Base
    def dump( thingy )
      puts thingy.to_s
      ( thingy.class.objc_instance_methods - SBApplication.objc_instance_methods ).sort.each do |m|
        puts " * #{ m }"
      end
    end
    
    def source
      "iphoto"
    end
    
    def load
      clear_events
      
      iphoto = SBApplication.applicationWithBundleIdentifier_("com.apple.iPhoto")

      last_event = nil
      iphoto.photos.each do |photo|
        event = find_or_create_event_for(photo, last_event)
        event.photos.create!(:name => photo.name.to_s, 
                             :external_key => photo.imagePath.to_s,
                             :source => source,
                             :date => Date.parse(photo.date.to_s),
                             :url => "file://" + photo.imagePath.to_s,
                             :thumbnail_url => "file://" + photo.thumbnailPath.to_s)
        last_event = event
      end
      update_event_date(last_event)
    end
    
    def update_event_date(event)
      event.date = event.photos.map {|p| p.date}.min
      event.save!
    end
    
    def find_or_create_event_for(photo, last_event)
      new_event_path = File.dirname(photo.imagePath.to_s)

      return last_event if last_event && new_event_path == last_event.external_key
      update_event_date(last_event) if last_event
      
      event = Event.find(:first, :conditions => ["external_key = ? and source = ?", new_event_path, source])
      return event if event
      
      Event.create!(:name => File.basename(new_event_path), :external_key => new_event_path, :source => source)
    end
  end
end
