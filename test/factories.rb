FactoryGirl.define do
  sequence :name do |n|
    "name-#{n}"
  end

  sequence :email do |n|
    "people#{n}@laposte.net"
  end

  factory :essai do
    exercice
  end

  factory :exercice do
  end

  factory :user do
    password 'truc'
    password_confirmation 'truc'
    email { generate(:email) }
    name { generate(:name) }
  end

  factory :qcm do
    lesson
    authors {|t| [t.association(:user)] }
  end

  factory :question do
    title "An ubber question"
    qcm
  end

  factory :choice do
    question
  end

  factory :answer do
    question
    user
    chosen_choices {|t| [t.association(:choice)] }
  end

  factory :lesson do
    title { generate(:name) }
    online false
  end

  factory :chapter do
    lesson
    title { generate(:name) }
    authors {|t| [t.association(:user)] }
  end

  factory :definition do
    keyword { generate(:name)}
    description { generate(:name)}
  end

  factory :message do
    title 'a title'
    status Message::NORMAL
    user
  end

  factory :submission do
    user
    chapter
    content 'something to test'
  end
end


