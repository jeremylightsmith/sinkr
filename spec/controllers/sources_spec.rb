require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Sources, "index action" do
  before(:each) do
    dispatch_to(Sources, :index)
  end
end