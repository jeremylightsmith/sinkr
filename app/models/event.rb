class Event < ActiveRecord::Base
  include Dated
  has_many :photos, :dependent => :destroy
  
  def name=(name)
    if name.to_s =~ /^(.+)\((\d+)\\?\/(\d+)\)$/
      self[:name] = $1.strip
      self.date = Date.parse("#{$2}/1/#{guess_year($3.to_i)}")
    else
      self[:name] = name
    end
  rescue
    puts "couldn't parse #{name}"
    raise
  end
end