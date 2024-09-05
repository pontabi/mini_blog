class FollowsController < ApplicationController
  def followings
    @user = User.find_by(id: params[:id])
    if @user
      @followings = @user.followings
    else
      flash[:alert] = "ユーザーが見つかりません"
      redirect_to root_path
    end
  end

  def followers
    @user = User.find_by(id: params[:id])
    if @user
      @followers = @user.followers
    else
      flash[:alert] = "ユーザーが見つかりません"
      redirect_to root_path
    end
  end

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.turbo_stream
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user, status: :see_other }
      format.turbo_stream
    end
  end
end
