FactoryGirl.define do
  sequence :name do |n|
    "name_#{n}"
  end

  factory :essai do
    exercice
    fichier { fixture_file_upload(Rails.root.join('test','essai_sample.rb'))}
    fichier_tests { fixture_file_upload(Rails.root.join('test','essai_sample_test.rb'))}

  end

  factory :exercice do
  end

  factory :user do
    password 'truc'
    password_confirmation 'truc'
    nom { generate(:name) }
  end

  factory :qcm do
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
end


