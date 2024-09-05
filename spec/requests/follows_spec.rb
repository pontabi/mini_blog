require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let!(:user) { create(:user) }
  describe "/followings/:id" do
    it "returns http success" do
      get "/followings/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /followers" do
    it "returns http success" do
      get "/followers/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
