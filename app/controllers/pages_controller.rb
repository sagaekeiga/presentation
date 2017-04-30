class PagesController < ApplicationController
  def index
    if user_signed_in?
      @microposts = Micropost.page(params[:page])
      @pro_mics = Micropost.where(purpose: 1).page(params[:page])
      @pre_mics = Micropost.where(purpose: 2).first(20)
      @clip_mics = current_user.clip_microposts
      @rank_mics = Micropost.all.sort_by{|ms|ms.rank}.reverse.first(20)
      @q = Micropost.search(params[:q])
    end
      @q = Micropost.search(params[:q])
  end
  
  
  # ----------------- 利用規約
  def agreement
  end
  
end
