class Admin < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password
  validates_confirmation_of :password
  
  def self.authenticate(email, password)
    admin = self.find_by_email(email)
    if admin
      expected_password = encrypted_password(password, admin.salt)
      if admin.hashed_password != expected_password
          admin = nil
        end
      end
      admin
    end
    # 'password' is a virtual attribute
    def password
      @password
    end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Admin.encrypted_password(self.password, self.salt)
  end

  private
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end