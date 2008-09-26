require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Event do
  describe "parsing dates out of names" do
    it "should know how to deal with no dates" do
      event = Event.new(:name => 'my event')
      event.name.should == "my event"
      event.date.should be_nil
      event.month.should be_nil
      event.year_month.should be_nil
      event.month_name.should be_nil
      event.year.should be_nil
    end

    it "should know how to parse a date" do
      event = Event.new(:name => 'my event (5/08)')
      event.name.should == "my event"
      event.date.should == Date.parse("5/1/2008")
      event.month.should == 5
      event.year_month.should == "2008-5"
      event.month_name.should == "May"
      event.year.should == 2008
    end
    
    it "should not care about flickr's weird \/" do
      Event.new(:name => 'my event (3\/09)').name.should == "my event"
    end

    it "should get right years" do
      Event.new(:name => 'my event (5/08)').year.should == 2008
      Event.new(:name => 'my event (5/50)').year.should == 2050
      Event.new(:name => 'my event (5/90)').year.should == 1990
      Event.new(:name => 'my event (5/80)').year.should == 1980
    end
  end
end