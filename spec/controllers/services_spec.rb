require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Services, "index action" do
  before(:each) do
    dispatch_to(Services, :index)
  end
end