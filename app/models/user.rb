require 'digest/sha1'

class User < ActiveRecord::Base
  has_secure_password

  has_many :essais, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

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

  def self.reset_password(email)
    user = User.where(email: email).first
    if user
      user.generate_reset_password_key!
      UserMailer.reset_password(user).deliver
    end
  end

  def update_password(password, password_confirmation)
    self.reset_password_key = nil
    self.password = password
    self.password_confirmation = password_confirmation
    self.save!
  end

  def self.inscription(email)
    user = new(email: email, name: email, password: email, password_confirmation: email)
    if user.save
      reset_password(email)
    else
      puts user.errors.full_messages
    end
    user
  end

end
