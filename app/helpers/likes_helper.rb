module LikesHelper
  def already_liked?(likes, user)
    likes.any? { |like| like.user_id == user.id }
  end
end
