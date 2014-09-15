require 'digest/sha1'

class User < ActiveRecord::Base
  has_secure_password

  has_many :essais, dependent: :destroy

  validates :name, uniqueness: true
  validates_presence_of :name

  def self.login(email, password)
    user = User.find_by(email: email)
    if user && user.reset_password_key.nil?
      user.authenticate(password)
    end
  end

  def local?
    ! self.remote?
  end

  def generate_reset_password_key!
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    salt = ""
    1.upto(7) { |i| salt << chars[rand(chars.size-1)] }
    key = Digest::SHA1.hexdigest("#{salt}--#{self.email}--")
    self.reset_password_key = key
    self.save!
  end
end
