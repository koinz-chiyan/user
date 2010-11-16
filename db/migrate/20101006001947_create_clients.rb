class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name, :null => false, :unique => true
      t.string :client_id, :null => false, :unique => true
      t.string :client_secret, :null => false
      t.timestamps
    end
    add_index :clients, :client_id, :unique => true
  end

  def self.down
    drop_table :clients
  end
end
