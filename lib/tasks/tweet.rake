namespace :tweet do
  desc "前日に投稿されたtweetのうち、いいねが多かったtweetを通知する"
  task notify_yesterday_top_liked_tweets: :environment do
    if TweetMailer.notify_yesterday_top_liked_tweets.deliver_now
      puts "いいねが多かったtweetを通知しました"
    else
      puts "いいねが多かったtweetの通知に失敗しました"
    end
  end
end
