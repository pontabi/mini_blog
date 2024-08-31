class UserBlog < ApplicationRecord
  KINDS = %w[Blog Instagram X Facebook Youtube Github LinkedIn Others].freeze

  belongs_to :user

  validates :url, presence: true
end
