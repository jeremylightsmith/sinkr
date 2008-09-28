require File.dirname(__FILE__) + '/../spec_helper'

describe Dated do
  class ADated < Hash
    include Dated
    
    def date
      self[:date]
    end
  end
  attr_reader :dated, :empty
  
  before do
    @dated = ADated.new
    @dated.date = Date.parse('2008-02-03')
    @empty = ADated.new
  end
  
  it "should make sure date is a date" do
    dated.date = "5/1/2008"
    dated.date.class.should == Date
    dated.date.should == Date.parse("2008-05-01")
  end
  
  it "should have a month" do
    dated.month.should == 2
    empty.month.should == nil
  end
  
  it "should have a year" do
    dated.year.should == 2008
    empty.year.should == nil
  end
  
  it "should have a year month" do
    dated.year_month.should == "2008-02"
    empty.year_month.should == nil
  end
  
  it "should have a month name" do
    dated.month_name.should == "February"
    dated.date = "2008-05-01"
    dated.month_name.should == "May"
    empty.month_name.should == nil
  end
end