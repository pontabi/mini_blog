class TweetMailer < ApplicationMailer
  def notify_reply_to_tweet
    @user = params[:user]
    @tweet = params[:tweet]
    @reply_tweet = params[:reply_tweet]
    mail(to: @user.email, subject: "【Mini Blog】あなたのツイートにリプライが届きました")
  end

  def notify_yesterday_top_liked_tweets
    @users = User.all
    @tweets = Tweet.yesterday.top_liked(10)
    mail(to: @users.pluck(:email), subject: "【Mini Blog】昨日のいいね数ランキングTOP10") if @tweets.present?
  end
end
