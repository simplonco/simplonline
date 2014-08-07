class User < ActiveRecord::Base
  has_secure_password

  has_many :essais, dependent: :destroy

  validates :nom, uniqueness: true

  def self.login(email, password)
    user = User.find_by(email: email)
    user.authenticate(password) if user
  end

end
