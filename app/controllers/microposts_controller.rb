class MicropostsController < ApplicationController
    before_action :user_signed_in?, only: [:create, :destroy, :new]

    def new
        @micropost = Micropost.new
        @contact = Contact.new
        @q = Micropost.search(params[:q])
        @activities = PublicActivity::Activity.all
    end
    
    def create
          @contact = Contact.new
          @q = Micropost.search(params[:q])
          @activities = PublicActivity::Activity.all
          
          @micropost = current_user.microposts.build(micropost_params)
          @micropost.purpose = params[:micropost][:purpose]
          
          @ids = params[:micropost][:tag_ids]
          @ids.delete_at(0)
          
          if @ids.empty?
              @caution = "タグを選択してください"
              render 'microposts/new'
          end
          
          if !@ids.empty?
            @tags = []
            @ids.each do |id|
              tag = Tag.find_by(id: id)
              @tags.push("#{tag.name}")
              tag.frequency = 1 + tag.frequency
              tag.save!
            end
            
  
            
            if @micropost.save
                redirect_to root_url
            else
                render 'microposts/new'
            end
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
      @q_mics = @q.result(distinct: true).page(params[:page])
      @all_q_mics = @q.result(distinct: true)
      @activities = PublicActivity::Activity.all
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
