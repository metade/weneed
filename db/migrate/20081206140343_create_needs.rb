class CreateNeeds < ActiveRecord::Migration
  def self.up
    create_table :needs do |t|
      t.column :parent_id, :int
      t.column :lft, :int
      t.column :rgt, :int
      t.column :name, :string
      t.timestamps
    end

    create_table :needs_users do |t|
      t.column :need_id, :int
      t.column :user_id, :int
    end
  end

  def self.down
    drop_table :needs
    drop_table :needs_users
  end
end
