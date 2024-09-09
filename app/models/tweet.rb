class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  belongs_to :parent, class_name: "Tweet", optional: true
  has_many :children, class_name: "Tweet", foreign_key: "parent_id", dependent: :destroy
  has_many_attached :images

  validates :content, presence: true, length: { maximum: 140 }
  validates :images, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }, limit: { max: 4 }

  scope :yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :top_liked, ->(num) { order(likes_count: :desc).limit(num) }
  scope :no_parent, -> { where(parent_id: nil) }

  def self.reply_with_increment(tweet, user)
    Tweet.transaction do
      reply = Tweet.new(user: user, parent: tweet, **tweet_params)
      reply.save!
      tweet.increment!(:replies_count)
      reply
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    nil
  end
end
