class Verificateur
  include Sidekiq::Worker

  def perform(essai_id)
    essai = Essai.find(essai_id)

    essai_contenu = File.open("#{Rails.root}/public#{essai.fichier_url}", "r").read

    output = `sudo docker run litaio/ruby /bin/echo -n "#{essai_contenu}" > test && bin/bash`
    #ruby -I. -e "require 'test'; app(#{essai.exercice.input})`
    if output == essai.exercice.expected_output
      essai.status = true
    else
      essai.status = false
    end
    essai.save
  end
end
