class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @tweet = Tweet.find(params[:tweet_id])

    ActiveRecord::Base.transaction do
      current_user.likes.create!(tweet: @tweet)
      @tweet.increment!(:likes_count)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @tweet }
    end
  end


  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    ActiveRecord::Base.transaction do
      current_user.likes.find_by(tweet: @tweet)&.destroy!
      @tweet.decrement!(:likes_count)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @tweet }
    end
  end

  def require_sign_in
    redirect_to new_user_session_path
  end
end
