class IphotoEvent < ExternalEvent
  has_many :photos, :class_name => 'IphotoPhoto', :foreign_key => 'external_event_id', :dependent => :destroy
  
  def element
    "$('#iphoto_event_#{id}')"
  end
  
  def load_photos
    photos.delete_all
    
    iphoto_album.photos.each do |photo|
      photos << IphotoPhoto.create!(:external_event_id => id,
                                    :name => photo.name.to_s, 
                                    :path => photo.imagePath.to_s,
                                    :date => Date.parse(photo.date.to_s),
                                    :url => "file://" + photo.imagePath.to_s,
                                    :thumbnail_url => "file://" + photo.thumbnailPath.to_s)
    end
    update_attribute(:loaded, true)
  end
  
  def self.reload_all
    IphotoEvent.delete_all
    IphotoPhoto.delete_all
    
    iphoto = OSX::SBApplication.applicationWithBundleIdentifier_("com.apple.iPhoto")
    
    folders = iphoto.albums.find_all{|a| a.properties['type'].stringValue == 'fldr'}
    folders.each do |folder|
      folder.children.each do |album|
        create!(:folder => folder.name,
                :name => album.name, 
                :album_id => album.properties['id'].to_s)
      end
    end
  end
  
  private
  
  def iphoto_album
    iphoto = OSX::SBApplication.applicationWithBundleIdentifier_("com.apple.iPhoto")
    iphoto.albums.find{|a| 
      a.properties['id'].to_s == album_id
    }
  end
end