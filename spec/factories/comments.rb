FactoryBot.define do
  factory :comment_module do
    body { Faker::Lorem.words }
    user_id { nil }
    micropost_id { nil }
  end
end
