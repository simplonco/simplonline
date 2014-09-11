FactoryGirl.define do
  sequence :name do |n|
    "name_#{n}"
  end

  factory :essai do
    exercice
  end

  factory :exercice do
  end

  factory :user do
    password 'truc'
    password_confirmation 'truc'
    name { generate(:name) }
  end

  factory :qcm do
    lesson
  end

  factory :question do
    qcm
  end

  factory :choice do
    question
  end

  factory :answer do
    question
    user
  end

  factory :lesson do
    title { generate(:name) }
  end

  factory :chapter do
    lesson
    title { generate(:name) }
  end
end


