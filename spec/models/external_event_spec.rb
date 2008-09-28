require File.dirname(__FILE__) + '/../spec_helper'

describe ExternalEvent do
  attr_reader :external_event, :event

  before(:each) do
    Event.delete_all
    @external_event = ExternalEvent.create!(:name => "crowd goes wild (6/07)")
    @event = external_event.event
  end
  
  it "should not change name of external event" do
    external_event.name.should == "crowd goes wild (6/07)"
  end

  it "should create event if there isn't one" do
    event.should_not be_nil
    event.name.should == "crowd goes wild"
    event.date.should == Date.parse("6/1/2007")
  end
  
  it "should attach to event if there is one" do
    new_event = ExternalEvent.create!(:name => "crowd goes wild (06:07)").event
    new_event.should == event
  end
  
  it "should move to a different event when name changes" do
    external_event.name = "nightlife (05/07)"
    external_event.save!
    external_event.event.should_not == event
    external_event.event.name.should == "nightlife"
  end
  
  it "should not match unless name and date match" do
    ExternalEvent.create!(:name => "crowd doesn't go wild (6/07)").event.should_not == event
    ExternalEvent.create!(:name => "crowd goes wild (5/07)").event.should_not == event
  end
  
  it "should delete an event when there are no more external events pointing at it" do
    external_event2 = ExternalEvent.create!(:name => "crowd goes wild (6/07)")
    Event.exists?(event).should be_true
    
    external_event.name = "other"
    external_event.save!
    Event.exists?(event).should be_true

    external_event2.name = "other"
    external_event2.save!
    ExternalEvent.exists?(external_event2).should be_true
    Event.exists?(event).should be_false
  end
  
  describe "parsing dates out of names" do
    it "should know how to deal with no dates" do
      split_name('my event').should == ["my event", nil]
    end

    it "should know how to parse a date" do
      split_name('my event (5/08)').should == ["my event", Date.parse("5/1/2008")]
    end
    
    it "should not care about flickr's weird \/" do
      split_name('my event (5\/08)').should == ["my event", Date.parse("5/1/2008")]
    end

    it "should handle :" do
      split_name('my event (5:08)').should == ["my event", Date.parse("5/1/2008")]
    end

    it "should get right years" do
      split_name('my event (5/08)')[1].year.should == 2008
      split_name('my event (5/50)')[1].year.should == 2050
      split_name('my event (5/90)')[1].year.should == 1990
      split_name('my event (5/80)')[1].year.should == 1980
    end
    
    def split_name(name)
      ExternalEvent.new(:name => name).send(:split_name)
    end
  end
end