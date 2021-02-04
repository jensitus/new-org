FactoryBot.define do
  factory :user do
    id { Faker::Internet.uuid}
    name { Faker::Name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
