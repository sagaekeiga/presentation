class MicropostsController < ApplicationController
    before_action :user_signed_in?, :except => ['show']

    def new
        @micropost = Micropost.new
        bar_option
        @tags = Tag.all
    end
    
    def create
          bar_option
          
          @micropost = current_user.microposts.build(micropost_params)
          @micropost.purpose = params[:micropost][:purpose]
          @params = params[:micropost][:taggings]

          user_rank
          
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
        @micropost = Micropost.find(params[:id])
        bar_option
        
        @comment = Comment.new
        @comments = @micropost.comments.includes(:user).all.sort_by{|ms|ms.created_at}
        
        @rank = REDIS.zincrby "microposts/all/#{Date.today.to_s}", 1, @micropost.id
        @micropost.rank = @rank
        @micropost.save!
        
        @pop_mics = @micropost.user.microposts.all.sort_by{|ms|ms.rank}.reverse.first(5)
        
        @microposts = Micropost.all
    end
    
    def edit
        @micropost = Micropost.find(params[:id])
        bar_option
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
      page_index
      @q_mics = @q.result(distinct: true).page(params[:index])
      @all_q_mics = @q.result(distinct: true)
    end
    
    def like_users
      bar_option
      @q_mics = @q.result(distinct: true).page(params[:page])
      @all_q_mics = @q.result(distinct: true)
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
