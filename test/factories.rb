FactoryGirl.define do
  factory :essai do
    exercice
  end

  factory :exercice do
  end

  factory :user do
    password 'truc'
    password_confirmation 'truc'
  end

  factory :qcm do
  end

  factory :question do
  end

  factory :lesson do
  end
end


