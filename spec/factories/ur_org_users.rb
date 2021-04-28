FactoryBot.define do
  factory :ur_org_user do
    id { Faker::Internet.uuid }
    user_id { Faker::Internet.uuid }
    name { Faker::Name }
    email { Faker::Internet.email }
  end
end

