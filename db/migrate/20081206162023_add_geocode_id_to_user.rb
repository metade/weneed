class AddGeocodeIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :geocode_id, :integer
  end

  def self.down
    remove_column :users, :geocode_id
  end
end
