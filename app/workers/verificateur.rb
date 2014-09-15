class Verificateur
  include Sidekiq::Worker

  def perform(essai)
    Dir.mkdir("/tmp/essai_#{essai.id}")
    File.open("/tmp/essai_#{essai.id}/essai.rb", "w") {|file| file.write("#{essai.fichier}")}
    # TODO - injecter la méthode d'exec du pgm -> 'app'
    output = `sudo docker run -v /tmp/essai_#{essai.id}:/home/sensei:ro -u sensei sensei/ruby ruby -I/home/sensei/ -e "require 'essai' ; puts app('#{essai.exercice.echantillon}')"`
    output.strip
  end
end
