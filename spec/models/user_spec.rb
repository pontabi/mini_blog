require 'rails_helper'

RSpec.describe User, type: :model do
  it "ネストされたuser_blogモデルを作成できること" do
    user = create(:user)
    expect {
      user.update(user_blogs_attributes: [
        { url: "https://my_blog.example.com", kind: "Blog" },
        { url: "https://instagram_account.example.com", kind: "Instagram" }
      ])
    }.to change { UserBlog.count }.by(2)
  end
end
