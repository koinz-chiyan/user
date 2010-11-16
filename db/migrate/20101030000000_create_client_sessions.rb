
class CreateClientSessions < ActiveRecord::Migration
  def self.up
    create_table :client_sessions do |t|
      t.string :client_id, :null => false
      t.string :auth_token, :null => false
      t.datetime :expiration, :null => false
    end
  end

  def self.down
    drop_table :client_sessions
  end
end
