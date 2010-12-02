
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
    currentTime = Time.now.utc
    uss = self.where(["user_email = ? and auth_token = ? and expiration > ?",email,token,currentTime])
    uss.length > 0
  end
end
