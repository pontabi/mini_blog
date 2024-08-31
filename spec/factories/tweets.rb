FactoryBot.define do
  factory :tweet do
    association :user

    user_id { user.id }
    content { Faker::Lorem.characters(number: 140) }

    trait :invalid do
      content { nil }
    end

    trait :another do
      content { Faker::Lorem.characters(number: 140) }
    end
  end
end
