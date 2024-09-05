require 'rails_helper'

RSpec.describe User, type: :model do
  let(:bob) { create(:user, :bob) }
  let(:alice) { create(:user, :alice) }

  it "ネストされたuser_blogモデルを作成できること" do
    expect {
      bob.update(user_blogs_attributes: [
        { url: "https://my_blog.example.com", kind: "Blog" },
        { url: "https://instagram_account.example.com", kind: "Instagram" }
      ])
    }.to change { UserBlog.count }.by(2)
  end

  describe "#follow" do
    it "フォローすること" do
      expect {
        bob.follow(alice)
      }.to change { bob.followings.count }.by(1)
    end

    it "フォローされること" do
      expect {
        bob.follow(alice)
      }.to change { alice.followers.count }.by(1)
    end
  end

  describe "#unfollow" do
    before do
      bob.follow(alice)
    end

    it "フォローを解除すること" do
      expect {
        bob.unfollow(alice)
      }.to change { bob.followings.count }.by(-1)
    end

    it "フォロー解除されること" do
      expect {
        bob.unfollow(alice)
      }.to change { alice.followers.count }.by(-1)
    end
  end

  describe "#following?" do
    it "フォローしていない場合はfalseを返すこと" do
      expect(bob.following?(alice)).to be_falsey
    end

    it "フォローしている場合はtrueを返すこと" do
      bob.follow(alice)
      expect(bob.following?(alice)).to be_truthy
    end
  end
end
