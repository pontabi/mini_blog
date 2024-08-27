require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "returns http ok" do
      get home_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /" do
    it "returns http ok" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
