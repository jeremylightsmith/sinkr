# ==== Set up load paths
$LOAD_PATH.unshift(Merb.root / "lib")

Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

# ==== Dependencies
dependencies "merb-more", "haml", "merb-haml", "merb_helpers", "merb-action-args", "merb-jquery"
require 'merb-haml'

dependency "flickraw", ">= 0.4.5"
require 'flickraw'
FlickRaw.api_key = '00633475f15879ad161d77bcb69b2ab5'
FlickRaw.shared_secret = '1b88f46d8c82ef6a'

dependency "file_sandbox", ">= 0.4"

require "array_ext"
require "dated"

require 'osx/cocoa'
OSX.require_framework 'ScriptingBridge'

Merb::BootLoader.after_app_loads do
end

# ==== Set up your ORM of choice
# use_orm :datamapper
use_orm :activerecord
# use_orm :sequel

use_test :rspec

# ==== Set up your basic configuration
Merb::Config.use do |c|
  c[:session_secret_key]  = 'f2389c809a3c0e1563eaaddb345da185c80ffca5'
  c[:session_store] = 'cookie'
  c[:flickr_user_id] = '30294775@N00'
end

