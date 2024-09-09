class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  def self.create_with_increment(tweet, user)
    Like.transaction do
      like = Like.create!(tweet: tweet, user: user)
      tweet.lock!
      tweet.increment!(:likes_count)
      like
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    # 失敗した場合のエラーハンドリング
    nil
  end
end
