class AddPhotosMigration < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.string :external_key
      t.string :source
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
