require File.dirname(__FILE__) + '/../spec_helper'

describe Iphoto do
  include FileSandbox
  attr_reader :iphoto

  before do
    sandbox.new :file => 'Originals/2007/Proposal/IMG_0.JPG'
    sandbox.new :file => 'Originals/2008/Wedding/IMG_1.JPG'
    sandbox.new :file => 'Originals/2008/Wedding/IMG_2.JPG'
    sandbox.new :file => 'Originals/2008/Reception/IMG_3.JPG'
    sandbox.new :file => 'Modified/2007/Proposal/IMG_0.JPG'

    @iphoto = Iphoto.new(sandbox.root)
  end
  
  it "should know about years" do
    iphoto.years.names.sort.should == %w(2007 2008)
  end
  
  it "should know about events" do
    iphoto.years.by_name('2007').events.names.should == %w(Proposal)
    iphoto.years.by_name('2008').events.names.sort.should == %w(Reception Wedding)
  end
  
  it "should about pictures"
  it "should superseed original locations with modified locations"
end