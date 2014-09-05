class Essai < ActiveRecord::Base
  belongs_to :exercice
  belongs_to :user

  validates_presence_of :exercice

  def fichier_name
    fichier_url.match(/[^\/]+$/)
  end

  def file_writer
    self.fichier = File.open(self.fichier.tempfile).read
  end

end
