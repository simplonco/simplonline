class Essai < ActiveRecord::Base
belongs_to :exercice


  def run

    require File.path('~/code/app/sensei/public/essais/' + self.content)
    
    if app(self.exercice.input) == self.exercice.expected_output
      true
    else
      false 
    end
  end
end
