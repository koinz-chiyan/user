
class AddUserEmailHash < ActiveRecord::Migration
  def self.up
    add_column :end_users, :email_hash, :string
  end

  def self.down
    remove_column :end_users, :email_hash
  end
end
