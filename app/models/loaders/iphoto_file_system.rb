module Loaders
  class IphotoFileSystem < Loaders::Base
    def source
      "iphoto"
    end
    
    def load
      clear_events
      
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
    end
  end
end
