class Client < ActiveRecord::Base
  def self.authenticate(clientId, clientSecret)
    client = self.where("client_id = '#{clientId}' and client_secret = '#{clientSecret}'").first
    if (client) 
      client.createAuthSession
    else
      nil
    end
  end

  def generateAuthToken
    Digest::MD5.hexdigest(self.client_secret + DateTime.now.to_s + rand.to_s)
  end

  def createAuthSession
    ClientSession.create({:client => self})
  end
end
