require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe "POST /create" do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, user: user) }
    let(:bob) { create(:user, :bob) }

    before { sign_in bob }

    it 'turb-streamリクエストが送れること・レスポンスが返ること' do
      # POSTリクエストを送信
      post tweet_like_path(tweet), headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }

      # ステータスコードが200 OKであることを確認
      expect(response).to have_http_status(:ok)

      # turbo_stream形式のレスポンスであることを確認
      expect(response.content_type).to include('text/vnd.turbo-stream.html')

      # turbo_streamの内容が含まれているか確認
      expect(response.body).to include("<turbo-stream action=\"replace\" target=\"like_#{tweet.id}\">")
    end

    it "いいねが作成されること" do
      expect {
        post tweet_like_path(tweet), headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      }.to change { tweet.likes.count }.by(1)
    end
  end

  describe "DELETE /destroy" do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, user: user) }
    let(:bob) { create(:user, :bob) }

    before do
      sign_in bob
      bob.likes.create(tweet: tweet)
    end

    it 'turb-streamリクエストが送れること・レスポンスが返ること' do
      delete tweet_like_path(tweet), headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }

      expect(response).to have_http_status(:ok)

      expect(response.content_type).to include('text/vnd.turbo-stream.html')

      expect(response.body).to include("<turbo-stream action=\"replace\" target=\"like_#{tweet.id}\">")
    end

    it "いいねが削除されること" do
      expect {
        delete tweet_like_path(tweet), headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      }.to change { tweet.likes.count }.by(-1)
    end
  end
end
