FactoryGirl.define do
  factory :user do |u|
    sequence(:email) { |n| "example#{n}@yahoo.com" }
    u.password { 'password' }
    u.password_confirmation { 'password' }
  end

  factory :vault do |v|
    v.name { "Vault" }
    v.exposure { rand(0..2) }
    v.user_id { rand(1..10) }
  end

  factory :snippet do |s|
    s.name { 'Snippet' }
    s.language { rand(0..30) }
    s.code { 'Test test test test' }
    s.vault_id { rand(1..100) }
  end
end
