class Verificateur
  include Sidekiq::Worker

  def perform(essai_id)
    essai = Essai.find(essai_id)
    # FAKE essai02 !!
    output = `sudo docker run -v #{essai.dossier}:/opt/dossier_essai:ro litaio/ruby ruby -Iopt/dossier_essai -e "require 'essai02'; puts app('#{essai.exercice.input}')"`
    if output.strip == essai.exercice.reponse
      essai.status = true
    else
      essai.status = false
    end
    essai.save
  end
end
