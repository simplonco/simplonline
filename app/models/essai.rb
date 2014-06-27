class Essai < ActiveRecord::Base
  belongs_to :exercice
  mount_uploader :fichier, FichierUploader

  def run
    require File.path("#{Rails.root}/public#{fichier_url}")
    self.fichier
    
    if app(self.exercice.input) == self.exercice.expected_output.to_i
      self.status = true
    else
      self.status = false
    end
    self.status
  end
end
