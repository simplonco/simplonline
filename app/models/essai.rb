class Essai < ActiveRecord::Base
  belongs_to :exercice
  mount_uploader :fichier, FichierUploader

  def dossier
    "#{Rails.root}/public/exercice/#{exercice.id}/user/essai/#{id}"
  end
end
