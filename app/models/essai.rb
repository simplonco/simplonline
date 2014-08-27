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

  def is_valid?
    case exercice.format_reponse
      when 1 #text
        reponse_char == exercice.reponse
      when 2 #JSON
        reponse_char == exercice.reponse
      when 3 #programme
        worker = Verificateur.new
        worker.perform(id) == exercice.reponse
      when 4 #programme + tests
      when 5 #test 
      end
  end
end
