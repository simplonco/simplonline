class ExerciceWorker
  include Sidekiq::Worker

  def perform(exercice_params)
    if Exercice.exists?(params[:id])
      Exercice.update(exercice_params)
    else
      Exercice.create(exercice_params) 
    end
  end
end
