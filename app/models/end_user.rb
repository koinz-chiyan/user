require 'digest/md5'

class EndUser < ActiveRecord::Base
  def self.create(data)
    data[:salt] = self.getSalt
    print data
    data[:hashed_password] = Digest::MD5.hexdigest(data.delete(:password) + data[:salt])
    data[:last_logged_in] = DateTime.now
    print data
    super(data)
  end

  def self.authenticate(email, pwd)
    user = self.find_by_email(email)
    hashed_pwd = Digest::MD5.hexdigest(pwd + user.salt)
    if (hashed_pwd == user.hashed_password)
      user.createAuthSession 
    else
      nil
    end
  end

  def generateAuthToken
    Digest::MD5.hexdigest(self.hashed_password + DateTime.now.to_s + rand.to_s)
  end

  def createAuthSession
    EndUserSession.create({:user => self})
  end

  private

  def self.getSalt
    self.object_id.to_s + rand.to_s
  end
end
