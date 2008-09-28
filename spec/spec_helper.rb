require 'rubygems'
require 'merb-core'

require 'spec' # Satiates Autotest and anyone else not using the Rake tasks
require 'file_sandbox_behavior'

Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
end

def flickr
  $flickr
end

def set_flickr(flickr)
  $flickr = flickr
end

module OSX
  class SBApplication
  end
end

def set_iphoto(iphoto)
  OSX::SBApplication.stub!(:applicationWithBundleIdentifier_).and_return(iphoto)
end

class String
  def stringValue
    self
  end
end