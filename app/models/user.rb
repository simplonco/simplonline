class User < ActiveRecord::Base
  has_secure_password

  has_many :essais, dependent: :destroy

  validates :name, uniqueness: true
  validates_presence_of :name

  def self.login(email, password)
    user = User.find_by(email: email)
    user.authenticate(password) if user
  end

  def local?
    ! self.remote?
  end
end
