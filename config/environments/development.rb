Merb.logger.info("Loaded DEVELOPMENT Environment...")
Merb::Config.use { |c|
  c[:exception_details] = true
  c[:reload_classes] = true
  c[:reload_time] = 0.5
  c[:log_auto_flush ] = true
}

dependency "flickraw", ">= 0.4.5"
require 'flickraw'
FlickRaw.api_key = '00633475f15879ad161d77bcb69b2ab5'
FlickRaw.shared_secret = '1b88f46d8c82ef6a'
require 'osx/cocoa'
OSX.require_framework 'ScriptingBridge'
