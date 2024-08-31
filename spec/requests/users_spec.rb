require 'rails_helper'

RSpec.describe "Users", type: :request do
  # only index show edit update
  describe "GET /users" do
    it "returns http success" do
      get users_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /users/:id" do
    it "returns http success" do
      user = create(:user)
      get user_url(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /users/:id/edit" do
    it "returns http success" do
      user = create(:user)
      sign_in user
      get edit_user_url(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /users/:id" do
    it "returns http success" do
      user = create(:user)
      sign_in user
      patch user_url(user), params: { user: { profile_message: "Hello, World!" } }
      expect(response).to redirect_to(user_url(user))
    end

    it "redirects to user profile" do
      user = create(:user)
      sign_in user
      patch user_url(user), params: { user: { profile_message: "Hello, World!" } }
      expect(response).to redirect_to(user_url(user))
    end

    it "updates user profile" do
      user = create(:user, profile_message: nil)
      sign_in user
      expect {
        patch user_url(user), params: { user: { profile_message: "Hello, World!" } }
      }.to change { user.reload.profile_message }.from(nil).to("Hello, World!")
    end
  end
end
