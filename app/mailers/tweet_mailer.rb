class TweetMailer < ApplicationMailer
  def notify_reply_to_tweet
    @user = params[:user]
    @tweet = params[:tweet]
    @reply_tweet = params[:reply_tweet]
    mail(to: @user.email, subject: "【Mini Blog】あなたのツイートにリプライが届きました")
  end
end
