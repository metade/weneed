class CreateGeocodesUsers < ActiveRecord::Migration
  def self.up
    create_table :geocodes_users, :id => false do |t|
      t.column :geocode_id, :int
      t.column :user_id, :int
    end
  end

  def self.down
  end
end
