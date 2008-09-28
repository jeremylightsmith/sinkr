class InitialTables < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.date :date
    end

    create_table :external_events do |t|
      t.integer :event_id
      t.string :name
      t.string :type
      t.boolean :loaded
      
      # iphoto
      t.string :folder
      t.string :album_id
      
      # flickr
      t.string :flickr_id
    end
    
    create_table :photos do |t|
      t.integer :external_event_id
      t.string :name
      t.string :type
      t.date :date

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
    drop_table :external_events
    drop_table :events
  end
end
