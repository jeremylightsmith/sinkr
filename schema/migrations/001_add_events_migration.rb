class AddEventsMigration < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :source
    end
  end

  def self.down
    drop_table :events
  end
end
