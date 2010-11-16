class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :end_users do |t|
      t.string :email, :null => false, :unique => true
      t.string :hashed_password, :null => false
      t.string :salt, :null => false
      t.string :facebook_snid, :null => true
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.boolean :verified, :null => false, :default => false
      t.datetime :last_logged_in, :null => false
      t.timestamps
    end
    add_index :end_users, :email, :unique => true
    add_index :end_users, :facebook_snid, :unique => true
  end

  def self.down
    drop_table :end_users
  end
end
