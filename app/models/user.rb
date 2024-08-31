class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  has_many :tweets
  has_many :user_blogs
  accepts_nested_attributes_for :user_blogs, allow_destroy: true

  validates :profile_message, length: { maximum: 200 }
end
