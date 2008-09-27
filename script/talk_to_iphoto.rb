require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'

def dump( thingy )
  puts thingy.to_s
  ( thingy.class.objc_instance_methods - SBApplication.objc_instance_methods ).sort.each do |m|
    puts " * #{ m }"
  end
end

def iphoto
  $iphoto ||= SBApplication.applicationWithBundleIdentifier_("com.apple.iPhoto")
end
