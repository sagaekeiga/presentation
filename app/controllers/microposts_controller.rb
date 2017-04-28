class MicropostsController < ApplicationController
    before_action :user_signed_in?, only: [:create, :destroy, :new]

    
    def new
        @micropost = Micropost.new
    end
    
    def create
          @micropost = current_user.microposts.build(micropost_params)

        if @micropost.save
            redirect_to root_url
        else
            redirect_to new_micropost_path
        end
    end
    
    def show
        @micropost = Micropost.find(params[:id])
        @comment = Comment.new
        @comments = @micropost.comments.includes(:user).all
    end
    
    private
    
     def micropost_params
         params.require(:micropost).permit(:content)
     end
end
