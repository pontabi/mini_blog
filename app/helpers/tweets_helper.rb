module TweetsHelper
  def tweet_owner?(tweet)
    user_signed_in? && current_user == tweet.user
  end
end
