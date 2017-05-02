class MicropostsController < ApplicationController
    before_action :user_signed_in?, only: [:create, :destroy, :new]
    before_action :set_available_tags_to_gon, only: [:new, :edit, :create, :update]
    
    def new
        @micropost = Micropost.new
        @contact = Contact.new
        @q = Micropost.search(params[:q])
        @activities = PublicActivity::Activity.all
    end
    
    def create
          @micropost = current_user.microposts.build(micropost_params)
          @micropost.purpose = params[:micropost][:purpose]

        if @micropost.save
            redirect_to root_url
        else
            redirect_to new_micropost_path
        end
    end
    
    def show
        @q = Micropost.search(params[:q])
        @micropost = Micropost.find(params[:id])
        @contact = Contact.new
        @comment = Comment.new
        @comments = @micropost.comments.includes(:user).all.sort_by{|ms|ms.created_at}
        @rank = REDIS.zincrby "microposts/all/#{Date.today.to_s}", 1, @micropost.id
        @micropost.rank = @rank
        @micropost.save!
        @activities = PublicActivity::Activity.all
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
        redirect_to edit_micropost_path
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

    def set_available_tags_to_gon
      gon.available_tags = Micropost.tags_on(:tags).pluck(:name)
    end
    
    private
    
     def micropost_params
         params.require(:micropost).permit(:content, :title, :rank, :purpose, :skill_list)
     end
end
