class Utilisateur < ActiveRecord::Base
  has_many :essais, dependent: :destroy
  validates :uid, presence: true
  validates :provider, presence: true
  validates :nom, uniqueness: true

  def self.create_with_omniauth(auth)
    create! do |utilisateur|
      utilisateur.provider = auth[:provider]
      utilisateur.uid = auth[:uid]
      # transforme emilien@simplon.co en emilien-d7x pour générer un nom d'utilisateur unique par défaut
      utilisateur.nom = auth[:info][:name] ? auth[:info][:name].split('@')[0][0..6] + '-' + rand(36**3).to_s(36) : rand(36**5).to_s(36)
    end
  end
end
