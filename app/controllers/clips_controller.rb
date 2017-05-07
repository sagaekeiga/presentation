class ClipsController < ApplicationController
    before_action :logged_in_user
  
    def create
        @micropost = Micropost.find(params[:micropost_id])
        @clip = current_user.clips.build(micropost_id: @micropost.id)
        @clip.save
    end
    
    
    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        @clip = current_user.clips.find_by!(micropost_id: params[:micropost_id])
        @clip.destroy
    end
end
