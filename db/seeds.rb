require "factory_bot_rails"

BLOG_KINDS = %w[Blog Instagram X Facebook Youtube Github LinkedIn Others]

############################
### ユーザーのデータを作成する
users = FactoryBot.create_list(:user, 10)
users.each do |user|
  user.user_blogs.create(url: "https://my_blog.example.com", kind: "Blog")
end
users.each do |user|
  FactoryBot.create_list(:tweet, 10, user: user)
end
users.each do |user|
  user.follow(users.sample(3) - [ user ])
end

############################
### アリスのデータを作成する
alice = FactoryBot.create(:user, :alice)
BLOG_KINDS.each do |kind|
  alice.user_blogs.create(url: "https://#{kind.downcase}_account.example.com", kind: kind)
end
FactoryBot.create_list(:tweet, 10, user: alice)

############################
### ボブのデータを作成する
bob = FactoryBot.create(:user, :bob)
BLOG_KINDS.each do |kind|
  bob.user_blogs.create(url: "https://#{kind.downcase}_account.example.com", kind: kind)
end
FactoryBot.create_list(:tweet, 10, user: bob)
