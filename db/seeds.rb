require "factory_bot_rails"

BLOG_KINDS = %w[Blog Instagram X Facebook Youtube Github LinkedIn Others]

alice = FactoryBot.create(:user, username: "alice", email: "alice@example.com")
BLOG_KINDS.each do |kind|
  alice.user_blogs.create(url: "https://#{kind.downcase}_account.example.com", kind: kind)
end

FactoryBot.create_list(:tweet, 10, user: alice)

bob = FactoryBot.create(:user, username: "bob", email: "bob@example.com")
BLOG_KINDS.each do |kind|
  bob.user_blogs.create(url: "https://#{kind.downcase}_account.example.com", kind: kind)
end
FactoryBot.create_list(:tweet, 10, user: bob)
