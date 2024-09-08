# Preview all emails at http://localhost:3000/rails/mailers/tweet_mailer
class TweetMailerPreview < ActionMailer::Preview
  def notify_reply_to_tweet
    TweetMailer.with(user: User.first, tweet: Tweet.first, reply_tweet: Tweet.last).notify_reply_to_tweet
  end
end
