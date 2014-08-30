class Essai < ActiveRecord::Base
  belongs_to :exercice
  belongs_to :user
  mount_uploader :fichier, FichierUploader
  mount_uploader :fichier_tests, FichierUploader

  validates_presence_of :exercice

  def dossier
    "#{Rails.root}/public/exercice/#{exercice.id}/user/essai/#{id}"
  end

  def fichier_name
    fichier_url.match(/[^\/]+$/)
  end

end
