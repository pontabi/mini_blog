require "factory_bot_rails"

if User.find_by(email: "alice@example.com").present?
  puts "Seed data already exists. Skipping..."
  return
end

BLOG_KINDS = %w[Blog Instagram X Facebook Youtube Github LinkedIn Others]

############################
### アリスのデータを作成する
alice = FactoryBot.create(:user, :alice)
BLOG_KINDS.each do |kind|
  alice.user_blogs.create(url: "https://#{kind.downcase}_account.example.com", kind: kind)
end
FactoryBot.create_list(:tweet, 10, user: alice, created_at: Faker::Time.between(from: 2.days.ago, to: DateTime.now))

############################
### ボブのデータを作成する
bob = FactoryBot.create(:user, :bob)
BLOG_KINDS.each do |kind|
  bob.user_blogs.create(url: "https://#{kind.downcase}_account.example.com", kind: kind)
end
FactoryBot.create_list(:tweet, 10, user: bob, created_at: Faker::Time.between(from: 2.days.ago, to: DateTime.now))

############################
### ユーザーのデータを作成する
users = FactoryBot.create_list(:user, 10)
users.each do |user|
  user.user_blogs.create(url: "https://my_blog.example.com", kind: "Blog")
end

# ツイートする
users.each do |user|
  10.times do
    FactoryBot.create(:tweet, user: user, created_at: Faker::Time.between(from: 2.days.ago, to: DateTime.now))
  end
end

# リプライする
users.each do |user|
  parents = Tweet.no_parent.sample(10)
  parents.each do |parent|
    parent.increment!(:replies_count)
    FactoryBot.create(:tweet, user: user, parent: parent, created_at: Faker::Time.between(from: parent.created_at, to: DateTime.now))
  end
end

# いいねをする
users.each do |user|
  Tweet.no_parent.sample(10).each do |tweet|
    Like.create_with_increment(tweet, user)
  end
end

# フォローする
users.each do |user|
  user.follow(users.sample(3) - [ user ])
end
