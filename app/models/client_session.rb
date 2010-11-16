
class ClientSession < ActiveRecord::Base
  def self.create(data)
    client = data.delete(:client)
    super({
            :client_id => client.client_id,
            :auth_token => client.generateAuthToken,
            :expiration => DateTime.now + 1000
          })
  end
  
  def self.authenticate(clientId, token)
    currentTime = Time.now
    css = self.where("client_id = '#{clientId}' and auth_token = '#{token}' and expiration > '#{currentTime}'")
    css.length > 0
  end
end
