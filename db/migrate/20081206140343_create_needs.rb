class CreateNeeds < ActiveRecord::Migration
  def self.up
    create_table :needs do |t|
      t.column :parent_id, :int
      t.column :lft, :int
      t.column :rgt, :int
      t.column :name
      t.timestamps
    end
  end

  def self.down
    drop_table :needs
  end
end
