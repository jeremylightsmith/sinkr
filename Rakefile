require 'rubygems'
Gem.clear_paths
Gem.path.unshift(File.join(File.dirname(__FILE__), "gems"))

require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'
require 'fileutils'
require 'merb-core'
require 'rubigen'
load 'lib/tasks/db_init.rake'
include FileUtils

# Load the basic runtime dependencies; this will include 
# any plugins and therefore plugin rake tasks.
init_env = ENV['MERB_ENV'] || 'rake'
Merb.load_dependencies(:environment => init_env)
     
# Get Merb plugins and dependencies
Merb::Plugins.rakefiles.each { |r| require r } 

desc "start runner environment"
task :merb_env do
  Merb.start_environment(:environment => init_env, :adapter => 'runner')
end

##############################################################################
# ADD YOUR CUSTOM TASKS BELOW
##############################################################################

task :default => :spec

desc "Show merb routes" 
task :routes => :merb_env do
  require 'merb-core/rack/adapter/irb'
  Merb::Rack::Console.new.show_routes
end

desc "Adds / removes changed files to git"
task :sync do
  puts `git add .`
  files = `git ls-files --deleted`.split
  puts `git rm #{files.map{|f| f.inspect}.join(" ")}` unless files.empty?
end

def run(cmd, options = {})
  puts cmd
  output = `#{cmd}`.strip
  puts output
  raise output unless $? == 0 or options[:ignore_errors] == true
end
