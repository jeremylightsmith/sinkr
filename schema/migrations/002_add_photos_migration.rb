class AddPhotosMigration < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.string :path
      t.integer :event_id
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
