class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :authorize_user, only: %i[ edit update ]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    # 10個のフォームを表示する
    @user.user_blogs.length.upto(9) { @user.user_blogs.build }
  end

  def update
    clean_user_blogs_params

    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def clean_user_blogs_params
      return unless params[:user] && params[:user][:user_blogs_attributes]

      params[:user][:user_blogs_attributes].each do |key, attributes|
        if attributes[:url].blank?
          attributes[:_destroy] = "1"
        end
      end
    end

    def user_params
      params.require(:user).permit(:profile_message, user_blogs_attributes: %i[ id url kind _destroy ])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def authorize_user
      unless helpers.self_user?(@user)
        redirect_to root_path, alert: "You are not authorized to do that."
      end
    end
end
