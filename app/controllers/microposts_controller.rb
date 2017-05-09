class MicropostsController < ApplicationController
    before_action :user_signed_in?, :except => ['show']

    def new
        @micropost = Micropost.new
        @contact = Contact.new
        @q = Micropost.search(params[:q])
        @activities = PublicActivity::Activity.all
        @tags = Tag.all
    end
    
    def create
          @contact = Contact.new
          @q = Micropost.search(params[:q])
          @activities = PublicActivity::Activity.all
          
          @micropost = current_user.microposts.build(micropost_params)
          @micropost.purpose = params[:micropost][:purpose]
          @params = params[:micropost][:taggings]

          if @micropost.save
            twitter_client
            tweet_post
            redirect_to @micropost
          else
            render 'microposts/new'
          end
    end
    
    def show
        @comment = params[:object]
        @q = Micropost.search(params[:q])
        @micropost = Micropost.find(params[:id])
        @contact = Contact.new if @comment.nil?
        @comment = Comment.new
        @comments = @micropost.comments.includes(:user).all.sort_by{|ms|ms.created_at}
        @rank = REDIS.zincrby "microposts/all/#{Date.today.to_s}", 1, @micropost.id
        @micropost.rank = @rank
        @micropost.save!
        @activities = PublicActivity::Activity.all
        @pop_mics = @micropost.user.microposts.all.sort_by{|ms|ms.rank}.reverse.first(5)
        
        @microposts = Micropost.all
        @relations = []
        
        
    end
    
    def edit
        @q = Micropost.search(params[:q])
        @micropost = Micropost.find(params[:id])
        @contact = Contact.new
        @activities = PublicActivity::Activity.all
    end
    
    def update
      @micropost = Micropost.find(params[:id])
      if @micropost.update(micropost_params)
        redirect_to @micropost
      else
        render 'edit'
      end
    end
    
    def index
      @contact = Contact.new
      @q = Micropost.search(params[:q])
      @q_mics = @q.result(distinct: true).page(params[:index])
      @activities = PublicActivity::Activity.all
      
      @tag_pops = Tag.all.sort_by{|ms|ms.frequency}.reverse.first(5)
      @tag_microposts = current_user.microposts.all
      
      @user_rank = User.all.order("score desc").first(10)
      calculate(current_user)
    end
    
    def like_users
      @contact = Contact.new
      @q = Micropost.search(params[:q])
      @q_mics = @q.result(distinct: true).page(params[:page])
      @all_q_mics = @q.result(distinct: true)
      @activities = PublicActivity::Activity.all
    end
    
    def admit_palace
      @microposts = Micropost.all
      @microposts.each do |micropost|
        if micropost.rank > 100000 && micropost.likes.count > 1000
          micropost.palace = true
        end
      end
    end
    
    private
    
     def micropost_params
         params.require(:micropost).permit(:content, :title, :rank, :purpose, { :tag_ids=> [] })
     end
end
