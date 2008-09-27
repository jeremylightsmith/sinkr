module Loaders
  class IphotoFileSystem < Loaders::Base
    def load
      IphotoEvent.delete_all
      IphotoPhoto.delete_all
      
      iphoto = Iphoto.new
      iphoto.years.each do |year|
        year.events.each do |iphoto_event|
          event = IphotoEvent.create!(:name => iphoto_event.name, :external_key => iphoto_event.path)
          iphoto_event.photos.each do |iphoto_photo|
            IphotoPhoto.create!(:event_id => event.id,
                                :name => iphoto_photo.name, 
                                :external_key => iphoto_photo.path, 
                                :date => iphoto_photo.date)
          end
          event.date = event.photos.map {|p| p.date}.min
          event.save!
        end
      end
    end
  end
end
