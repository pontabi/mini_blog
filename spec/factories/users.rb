FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    profile_message { "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " }

      trait :bob do
        username { "bob" }
        email { "bob@example.com" }
      end

      trait :alice do
        username { "alice" }
        email { "alice@example.com" }
      end
  end
end
