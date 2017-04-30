class PagesController < ApplicationController
  def index
    if user_signed_in?
      @microposts = Micropost.page(params[:page])
      @clip_mics = current_user.clip_microposts
      @rank_mics = Micropost.all.sort_by{|ms|ms.rank}.reverse
      @q = Micropost.search(params[:q])
    end
  end
  
end
