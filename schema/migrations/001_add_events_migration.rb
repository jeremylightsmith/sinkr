class AddEventsMigration < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :external_key
      t.string :source
      t.date :date
    end
  end

  def self.down
    drop_table :events
  end
end
