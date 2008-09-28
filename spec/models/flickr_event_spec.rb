require File.dirname(__FILE__) + '/../spec_helper'

describe FlickrEvent do
  describe "load_photos" do
    it "should load photos" do
      set_flickr stub('flickr', 
                      :photosets => stub('photosets', 
                                         :getPhotos => stub('photos', :photo => [photo_stub(:one), photo_stub(:two)])))

      event = FlickrEvent.create!
      event.load_photos
      event.reload
      
      event.photos.size.should == 2
      p = event.photos.first
      p.name.should == "one"
      p.date.should == Date.today
      p.flickr_id.should == "5"
      p.server.should == "1"
      p.secret.should == 'secret'
      p.farm.should == "2"
    end
    
    def photo_stub(name)
      stub "photo_#{name}", 
           :title => name.to_s, 
           :datetaken => Date.today, 
           :id => 5, 
           :server => 1, 
           :secret => 'secret', 
           :farm => 2
    end
  end
  
  describe "reload_all" do
    it "should reload all" do
      set_flickr stub('flickr', 
                      :photosets => stub('photosets', 
                                         :getList => [set_stub(:one), set_stub(:two)]))
      
      FlickrEvent.create!
      FlickrEvent.reload_all
      
      events = FlickrEvent.find(:all, :order => 'id')
      events.size.should == 2
      events.first.name.should == "one"
      events.first.flickr_id.should == "5"
      events.last.name.should == "two"
    end
    
    def set_stub(name)
      stub "set_#{name}", :title => name.to_s, :id => 5
    end
  end
end