class AddPhotosMigration < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :event_id
      t.string :name
      t.string :type
      t.date :date
      t.integer :year

      # iphoto
      t.string :path
      t.string :url
      t.string :thumbnail_url
      
      # flickr
      t.string :farm
      t.string :server
      t.string :flickr_id
      t.string :secret
    end
  end

  def self.down
    drop_table :photos
  end
end
