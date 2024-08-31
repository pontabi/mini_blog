FactoryBot.define do
  factory :user_blog do
    user { :user }
    url { "https://my_blog.example.com" }
    type { "Blog" }

    trait :instagram do
      url { "https://instagram_account.example.com" }
      type { "Instagram" }
    end

    trait :x do
      url { "https://x_account.example.com" }
      type { "X" }
    end

    trait :facebook do
      url { "https://facebook_account.example.com" }
      type { "Facebook" }
    end

    trait :youtube do
      url { "https://youtube_account.example.com" }
      type { "Youtube" }
    end

    trait :github do
      url { "https://github_account.example.com" }
      type { "Github" }
    end

    trait :linkedin do
      url { "https://linkedin_account.example.com" }
      type { "LinkedIn" }
    end

    trait :others do
      url { "https://other_personal_blog.example.com" }
      type { "Others" }
    end
  end
end
