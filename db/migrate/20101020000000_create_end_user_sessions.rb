
class CreateEndUserSessions < ActiveRecord::Migration
  def self.up
    create_table :end_user_sessions do |t|
      t.string :user_email, :null => false
      t.string :auth_token, :null => false
      t.datetime :expiration, :null => false
    end
  end

  def self.down
    drop_table :end_user_sessions
  end
end
