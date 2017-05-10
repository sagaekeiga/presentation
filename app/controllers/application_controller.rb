class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "ログインしてください"
      redirect_to root_url
    end
  end
    
  def calculate(user)
    microposts = user.microposts
    #----------------------------評価
    @like_score = 0
    microposts.each do |micropost|
      @like_score += micropost.likes.count
    end
    @like_score = @like_score*3
    
    #----------------------------クリップ
    @clip_score = 0
    microposts.each do |micropost|
      @clip_score += micropost.clips.count
    end
    
    #----------------------------PV
    @pv_score = 0
    microposts.each do |micropost|
      @pv_score += micropost.rank
    end
    @pv_score = @pv_score*0.5
    
    #----------------------------タグ
    @tag_score = 0
    microposts.each do |micropost|
      @tag_score += micropost.tags.count
    end
    @tag_score = @tag_score*0.5
  
    #----------------------------投稿
    @post_score = 0
    @post_score = user.microposts.count
    
    #----------------------------フォロー
    @following_score = 0
    @following_score = user.following.count
    @following_score = @following_score*0.5

    #----------------------------フォロワー
    @follower_score = 0
    @follower_score = user.followers.count
    @follower_score = @follower_score*2
    
    #----------------------------総得点
    @all_score = @like_score + @clip_score + @pv_score + @tag_score + @post_score + @following_score + @follower_score
    user.score = @all_score
    user.save
  end
  
  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "63bS01JjSI9ZGP7fnBC41FwCa"
      config.consumer_secret = "Dt1Lm51AA641UwML7W7QvIsJobJI2oxxQckierzATl6gFdetzf"
      config.access_token = "861829757855551488-VixsONxjkhiZickZ8cfs2fr50Q8GBgz"
      config.access_token_secret = "KwJwqIzNrX89ENWbGsVhUWY2o1W9z8pQiqClFika5OS0S"
    end
  end
  
  def tweet_post
      tweet = Micropost.last
      status = "http://ruppish.com/microposts/microposts/" + tweet.id.to_s
      @client.update(status)
  end
  
  def page_index
      @contact = Contact.new
      @q = Micropost.search(params[:q])
      @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
    
      @tag_pops = Tag.all.sort_by{|ms|ms.frequency}.reverse.first(5)
      @tag_microposts = current_user.microposts.all
      
      @rank_title = Micropost.order("rank DESC").first
      @user_rank = User.all.order("score desc").first(10)
      calculate(current_user)
  end
  
  def bar_option
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
  end
  
  def user_rank
    @contact = Contact.new
    @activities = PublicActivity::Activity.all
    @q = Micropost.search(params[:q])
    
    @users = User.all.order("score desc")
    @rank = 1
    @users.each do |user|
      user.rank = @rank
      @rank += 1
      user.save
    end
  end
    
    
  protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :job, :prefecture, :profile, :blog, :score])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :job, :prefecture, :profile, :blog])
      end
end
