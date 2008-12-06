class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :user_id
      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
