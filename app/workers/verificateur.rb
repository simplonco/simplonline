class Verificateur
  include Sidekiq::Worker

  def perform(essai_id)
    essai = Essai.find(essai_id)
    output = `sudo docker run -v #{Rails.root}/public/essai_sample:/opt/essai_sample:ro litaio/ruby ruby -Iopt/essai_sample -e "require 'essai02'; puts app('#{essai.exercice.input}')"`
    
    if output.strip == essai.exercice.expected_output
      essai.status = true
    else
      essai.status = false
    end
    essai.save
  end
end
