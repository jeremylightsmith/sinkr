require File.dirname(__FILE__) + '/../spec_helper'

describe IphotoEvent do
  describe "reload_all" do
    it "should reload all events" do
      one, two, three = album_stub(:one), album_stub(:two), album_stub(:three)
      set_iphoto stub("iphoto", :albums => [
          stub("events", :name => "events", :properties => {'type' => 'something'}),
          stub("photos", :name => "photos", :properties => {'type' => 'smartList'}),
          stub("events", :name => "2008", :properties => {'type' => 'fldr'}, :children => [one, two]),
          stub("events", :name => "2007", :properties => {'type' => 'fldr'}, :children => [three]),
          stub("events", :name => "events", :properties => {'type' => 'list'}),
          one, two
      ])
      
      IphotoEvent.create!
      IphotoEvent.reload_all
      
      events = IphotoEvent.find(:all, :order => 'id')
      events.size.should == 3
      events.map(&:name).should == %w(one two three)
      events.map(&:folder).should == %w(2008 2008 2007)
      events[0].album_id.should == "5"
    end
  end
  
  describe "iphoto_album" do
    it "should find appropriate iphoto album" do
      set_iphoto stub("iphoto", :albums => [album_stub("events", 1), 
                                            album_stub("something", 2),
                                            foo = album_stub("foo", 3)
      ])
      IphotoEvent.new(:album_id => "3").send(:iphoto_album).should == foo
    end
  end

  describe "load_photos" do
    it "should load photos" do
      event = IphotoEvent.create!
      event.stub!(:iphoto_album).and_return(stub("album", :photos => [
        photo_stub("one"), photo_stub("two"), photo_stub("three")
      ]))
      
      event.photos.create!
      event.should_not be_loaded
      event.load_photos

      event.should be_loaded
      event.photos.size.should == 3
      event.photos.map(&:name).should == %w(one two three)
      one = event.photos.first
      one.path.should == "path/one.jpg"
      one.date.should == Date.today
      one.url.should == "file://path/one.jpg"
      one.thumbnail_url.should == "file://thumbnail/one.jpg"
    end
  end
  
  def photo_stub(name)
    stub("photo_#{name}", :name => name, 
                          :date => Date.today.to_s, 
                          :imagePath => "path/#{name}.jpg", 
                          :thumbnailPath => "thumbnail/#{name}.jpg")
  end
  
  def album_stub(name, id = 5)
    stub(name, :name => name.to_s, :properties => {"type" => 'albm', 'id' => id})
  end
end