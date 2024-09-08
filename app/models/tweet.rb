class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  belongs_to :parent, class_name: "Tweet", optional: true
  has_many :children, class_name: "Tweet", foreign_key: "parent_id"

  validates :content, presence: true, length: { maximum: 140 }
end
