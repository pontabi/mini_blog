FactoryBot.define do
  factory :tweet do
    association :user

    user_id { user.id }
    content { "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua" }
  end
end
