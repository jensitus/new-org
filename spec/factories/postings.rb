FactoryBot.define do
  factory :posting do
    title { Faker::Lorem.word }
    content { Faker::Lorem.words }
    user_id { Faker::Internet.uuid }
  end
end
