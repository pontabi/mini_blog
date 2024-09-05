class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  has_many :tweets
  has_many :user_blogs
  accepts_nested_attributes_for :user_blogs, allow_destroy: true
  has_many :active_relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :profile_message, length: { maximum: 200 }

  def follow(user)
    followings << user unless following?(user) || self == user
  end

  def unfollow(user)
    followings.delete(user)
  end

  def following?(user)
    followings.include?(user)
  end
end
