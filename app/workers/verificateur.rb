class Verificateur
  include Sidekiq::Worker

  def perform(essai)
    puts "SUCCES le Vérificateur a fonctionné"
    #output = `sudo docker run -v /opt litaio/ruby echo "#{puts essai.fichier}" >> monessai && ruby -Iopt/ -e "require 'monessai'; puts app('#{essai.exercice.echantillon}')"`
    #output.strip
  end
end
