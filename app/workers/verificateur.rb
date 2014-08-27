class Verificateur
  include Sidekiq::Worker

  def perform(essai_id)
    essai = Essai.find(essai_id)
    output = `sudo docker run -v #{essai.dossier}:/opt/dossier_essai:ro litaio/ruby ruby -Iopt/dossier_essai -e "require '#{essai.fichier_name}'; puts app('#{essai.exercice.echantillon}')"`
    output.strip
  end
end
