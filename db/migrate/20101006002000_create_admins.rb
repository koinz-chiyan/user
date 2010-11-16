class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :email, :null => false, :unique => true
      t.string :hashed_password, :null => false
      t.string :salt, :null => false
      t.timestamps
    end
    add_index :admins, :email, :unique => true
  end

  def self.down
    drop_table :admins
  end
end
