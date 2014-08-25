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
    qcm
  end

  factory :choice do
    question
  end

  factory :lesson do
  end
end


