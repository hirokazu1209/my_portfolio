FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "test1234" }
    self_introduction { Faker::Lorem.characters(number: 60) }
  end
end
