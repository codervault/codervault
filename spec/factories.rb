FactoryGirl.define do

  factory :user do |u|
    u.email { 'example@yahoo.com' }
    u.password { 'password' }
    u.password_confirmation { 'password' }
  end

  factory :vault do |v|
    v.name { "Test" }
    v.exposure { 1 }
    v.user_id { rand(1..10) }
  end

  factory :snippet do |s|
    s.name { 'test' }
    s.language { rand(1..30) }
    s.code { 'Test test test test' }
    s.vault_id { rand(1..100) }
  end
end