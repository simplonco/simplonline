require 'digest/sha1'

class User < ActiveRecord::Base
  has_secure_password

  has_many :essais, dependent: :destroy

  LOCAL = :local
  REMOTE = :remote
  STAFF = :staff

  validates :student_type, presence: true
  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  scope :authors, -> { where(student_type: User::LOCAL) }

  def self.login(email, password)
    user = User.find_by(email: email)
    if user && user.reset_password_key.nil?
      user.authenticate(password)
    end
  end

  def local?
    self.student_type.to_s == User::LOCAL.to_s
  end

  def remote?
    self.student_type.to_s == User::REMOTE.to_s
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
    save_and_reset_password(email, User::REMOTE)
  end

  def self.inscription_local(email)
    save_and_reset_password(email, User::LOCAL)
  end

  def self.inscription_staff(email)
    save_and_reset_password(email, User::STAFF)
  end

  def name
    db_name = read_attribute(:name)
    if db_name
      db_name
    else
    end
  end

  private

  def self.generate_password
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(7) { |i| newpass << chars[rand(chars.size-1)] }
    newpass
  end

  def self.save_and_reset_password(email, status)
    tmp_pwd = generate_password
    user = new(email: email, name: email.split('@').first, password: tmp_pwd, password_confirmation: tmp_pwd, student_type: status)

    if user.save
      reset_password(user.email)
    else
      puts user.errors.full_messages
    end
    user
  end
end
