class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :authorize_owner, only: %i[ edit update destroy ]

  def index
    @filter = params[:filter] || "all"
    if @filter == "following"
      # ログイン中のユーザーがフォローしているユーザーのツイートを取得
      @tweets = Tweet.includes(:user, :likes, :parent, :children).where(user: current_user.followings).order(created_at: :desc).page(params[:page])
    else
      @tweets = Tweet.includes(:user, :likes, :parent, :children).order(created_at: :desc).page(params[:page])
    end
  end

  def show
    @children = @tweet.children.includes(:user, :likes)
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    if @tweet.save
      if tweet_params[:parent_id].present?
        TweetMailer.with(user: @tweet.parent.user, tweet: @tweet.parent, reply_tweet: @tweet)
                   .notify_reply_to_tweet
                   .deliver_later
      end

      redirect_to tweet_url(@tweet), notice: "Tweet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    if @tweet.update(tweet_params)
      flash.now.notice = "ツイートを更新しました"
    else
      # バリデーションエラー時にはedit.html.erbをrenderする
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy!
    flash.now.notice = "ツイートが削除されました。"
  end

  # GET /tweets/:id/new_reply
  def new_reply
    @parent_tweet = Tweet.find(params[:id])
    @reply_tweet = Tweet.new(parent_id: params[:id])
  end

  private
    def tweet_params
      params.require(:tweet).permit(:content, :parent_id, images: [])
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def authorize_owner
      unless helpers.tweet_owner?(@tweet)
        redirect_to root_url, alert: "You don't have permission to do that."
      end
    end
end
