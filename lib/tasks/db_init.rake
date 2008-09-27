require 'yaml'

namespace :db do
  task :init do
    settings = YAML::load_file(File.dirname(__FILE__) + "/../../config/database.yml")
    environments = ENV['MERB_ENV'] ? [ENV['MERB_ENV']] : ["development", "test"]

    environments.each do |env|
      db, user, pass = settings[env]['database'], settings[env]['username'], settings[env]['password']
      
      puts "initialize the #{env} database"
      run(%{mysql -u#{user} -p#{pass} -e "drop database if exists #{db}; create database #{db} character set utf8;"})
      run(%{rake db:migrate MERB_ENV=#{env} 2>&1})
    end
  end
end
