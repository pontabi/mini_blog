module TweetsHelper
  def owner?(tweet)
    user_signed_in? && current_user == tweet.user
  end
end
