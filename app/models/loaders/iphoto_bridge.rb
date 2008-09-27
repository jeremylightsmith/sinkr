module Loaders
  class IphotoBridge < Loaders::Base
    def dump( thingy )
      puts thingy.to_s
      ( thingy.class.objc_instance_methods - SBApplication.objc_instance_methods ).sort.each do |m|
        puts " * #{ m }"
      end
    end
    
    def load
      IphotoEvent.delete_all
      IphotoPhoto.delete_all
      
      iphoto = SBApplication.applicationWithBundleIdentifier_("com.apple.iPhoto")

      last_event = nil
      iphoto.photos.each do |photo|
        event = find_or_create_event_for(photo, last_event)
        IphotoPhoto.create!(:event_id => event.id,
                            :name => photo.name.to_s, 
                            :path => photo.imagePath.to_s,
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
      new_event_path = photo.imagePath.to_s.split("/")[-3..-2].join("/")

      return last_event if last_event && new_event_path == last_event.external_key
      update_event_date(last_event) if last_event
      
      event = IphotoEvent.find(:first, :conditions => ["external_key = ?", new_event_path])
      return event if event
      
      IphotoEvent.create!(:name => File.basename(new_event_path), :external_key => new_event_path)
    end
  end
end
