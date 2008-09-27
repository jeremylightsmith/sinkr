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

def d(obj)
  case obj
  when String, OSX::NSString
    obj
  when Array, SBElementArray
    d_array(obj)
  when OSX::IPhotoAlbum
    d_album(obj)
  else
    "don't know how to display #{obj.class}:"
    obj.to_s
  end
end

def d_album(a)
  "#{a.name}:#{a.class} > \n#{d(a.children).gsub(/^/, '  ')}"
end

def d_array(a)
  a.map {|e| d e}.join("\n")
end
