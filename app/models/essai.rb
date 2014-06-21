class Essai < ActiveRecord::Base
belongs_to :exercice
mount_uploader :fichier, FichierUploader

  def load_file
    require File.path('~/code/app/sensei/public/' + self.fichier_url)
  end

  def run  
    if app(self.exercice.input) == self.exercice.expected_output
      self.status = true
    else
      self.status = false 
    end
    self.status
  end
end
