FactoryBot.define do
  factory :comment_module do
    body { Faker::Lorem.words }
    user_id { nil }
    posting_id { nil }
  end
end
