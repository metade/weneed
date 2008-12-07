class AddLatlngToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :latlng, :string
  end

  def self.down
    remove_column :addresses, :latlng
  end
end
