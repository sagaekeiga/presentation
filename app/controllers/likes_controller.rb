class LikesController < ApplicationController
   before_action :logged_in_user

    def create
        @micropost = Micropost.find(params[:micropost_id])
        @like = current_user.likes.build(micropost_id: @micropost.id)
        @like.save
        @like.create_activity :create, owner: current_user
    end
    
    
    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        @like = current_user.likes.find_by!(micropost_id: params[:micropost_id])
        @like.destroy
    end
end
