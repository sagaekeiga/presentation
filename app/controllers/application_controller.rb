class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
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
    
    
  protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :job, :prefecture, :profile, :blog, :score])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :job, :prefecture, :profile, :blog])
      end
end
