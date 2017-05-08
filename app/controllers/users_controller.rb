class UsersController < ApplicationController
    before_action :logged_in_user

    def index
      @users = User.all
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = User.search(params[:q])
      @search = params[:q][:search] if !params[:q].nil?
      @q_users = @q.result(distinct: true).page(params[:index])
    end
    
    def show
      @user = User.find(params[:id])
      
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = Micropost.search(params[:q])
      
      @microposts = @user.microposts.order("created_at DESC").page(params[:micropost])
      @following_users = @user.following.order("created_at DESC").page(params[:following])
      @followers_users = @user.followers.order("created_at DESC").page(params[:followed])

      @chart_data = User.group(:created_at).sum(:score)
      calculate(@user)
    end
    
    def clip_posts
      @user = User.find(params[:id])
      
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = Micropost.search(params[:q])
      
      @clips = @user.clip_microposts.order("created_at DESC").page(params[:clip])
      @following_users = @user.following.order("created_at DESC").page(params[:following])
      @followers_users = @user.followers.order("created_at DESC").page(params[:followed])
      
      calculate(@user)
    end
    
    def like_posts
      @user = User.find(params[:id])
      
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = Micropost.search(params[:q])
      
      @likes = @user.like_microposts.order("created_at DESC").page(params[:like])
      @following_users = @user.following.order("created_at DESC").page(params[:following])
      @followers_users = @user.followers.order("created_at DESC").page(params[:followed])

      calculate(@user)
    end
    
    def following_users
      @user = User.find(params[:id])
      
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = Micropost.search(params[:q])
      
      @following_users = @user.following.order("created_at DESC").page(params[:following])
      @followers_users = @user.followers.order("created_at DESC").page(params[:followed])
      
      calculate(@user)
    end
    
    def followed_users
      @user = User.find(params[:id])
      
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = Micropost.search(params[:q])
      
      @following_users = @user.following.order("created_at DESC").page(params[:following])
      @followers_users = @user.followers.order("created_at DESC").page(params[:followed])
      
      calculate(@user)
    end
    
    
    
    def tags
      @user = User.find(params[:id])
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = Micropost.search(params[:q])
      
      @microposts = @user.microposts.order("created_at DESC").page(params[:micropost])
      @following_users = @user.following.order("created_at DESC").page(params[:following])
      @followers_users = @user.followers.order("created_at DESC").page(params[:followed])
      
      calculate(@user)
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
    
    def chart
      @user = User.find(params[:id])
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @q = Micropost.search(params[:q])
      calculate(@user)

      #------------ユーザー個人値
      gon.user_name = @user.name
      gon.clip = @clip_score
      gon.pv = @pv_score
      gon.post_m = @post_score
      gon.following = @following_score
      gon.follower = @follower_score
      gon.tag = @tag_score
      gon.like = @like_score
      
      #------------ユーザー全体値
      
    end
    
    
    def update
      p user_params
      respond_to do |format|
        if @user.update_without_current_password(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
end
