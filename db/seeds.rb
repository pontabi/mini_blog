require "factory_bot_rails"

alice = FactoryBot.create(:user, username: "alice", email: "alice@example.com")
FactoryBot.create_list(:tweet, 10, user: alice)

bob = FactoryBot.create(:user, username: "bob", email: "bob@example.com")
FactoryBot.create_list(:tweet, 10, user: bob)
