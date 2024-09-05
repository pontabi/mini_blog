FactoryBot.define do
  factory :tweet do
    association :user

    user_id { user.id }
    content { Faker::Lorem.sentences(number: 10).join }

    trait :invalid do
      content { nil }
    end

    trait :another do
      content { Faker::Lorem.sentences(number: 10).join }
    end
  end
end
