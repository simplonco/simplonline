class Exercice < ActiveRecord::Base
  has_many :essais, dependent: :destroy
end
