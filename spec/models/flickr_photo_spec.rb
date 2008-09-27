require File.dirname(__FILE__) + '/../spec_helper'

describe FlickrPhoto do
  describe "urls" do
    before do
      @photo = FlickrPhoto.new(:farm => 1, :server => 2, :flickr_id => 3, :secret => "4bf")
    end

    it "should calculate it's thumbnail url" do
      @photo.thumbnail_url.should == "http://farm1.static.flickr.com/2/3_4bf_s.jpg"
    end

    it "should calculate it's url" do
      @photo.url.should == "http://farm1.static.flickr.com/2/3_4bf.jpg"
    end
  end
end