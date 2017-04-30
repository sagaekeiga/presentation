class PagesController < ApplicationController
  def index
    if user_signed_in?
      @microposts = Micropost.page(params[:page])
      @clip_mics = current_user.clip_microposts
      @rank_mics = Micropost.all.order('rank').sort_by{|ms|ms.rank}.reverse
    end
  end
  
end
