FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@yahoo.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :vault do
    name { "Vault" }
    exposure { rand(0..2) }
    user
  end

  factory :snippet do
    name { 'Snippet' }
    language { rand(0..30) }
    code { 'Test test test test' }
    vault
  end
end
