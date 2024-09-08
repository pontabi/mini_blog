class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  belongs_to :parent, class_name: "Tweet", optional: true
  has_many :children, class_name: "Tweet", foreign_key: "parent_id"
  has_many_attached :images

  validates :content, presence: true, length: { maximum: 140 }
  validates :images, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }, limit: { max: 4 }
end
