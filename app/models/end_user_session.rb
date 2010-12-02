
class EndUserSession < ActiveRecord::Base
  def self.create(data)
    user = data.delete(:user)
    super({
            :user_email => user.email_hash,
            :auth_token => user.generateAuthToken,
            :expiration => Time.now + 30 * 60
          })
  end
  
  def self.authenticate(email, token)
    currentTime = Time.now
    uss = self.where("user_email = '#{email}' and auth_token = '#{token}' and expiration > '#{currentTime}'")
    uss.length > 0
  end
end
