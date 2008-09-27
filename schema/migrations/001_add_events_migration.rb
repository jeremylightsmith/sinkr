class AddEventsMigration < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :external_key
      t.string :type
      t.date :date
      t.string :collection
      t.boolean :loaded
    end
  end

  def self.down
    drop_table :events
  end
end
