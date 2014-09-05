class ExerciceWorker
  include Sidekiq::Worker

  def perform(exercice_params)
    Exercice.create(exercice_params)
  end
  #TODO - perform for update exercice
end
