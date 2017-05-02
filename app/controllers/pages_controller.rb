class PagesController < ApplicationController
  def index
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    if user_signed_in?
      @microposts = Micropost.page(params[:page])
      @pro_mics = Micropost.where(purpose: 1).page(params[:vip_page])
      @pre_mics = Micropost.where(purpose: 2).first(20)
      @clip_mics = current_user.clip_microposts
      @rank_mics = Micropost.all.sort_by{|ms|ms.rank}.reverse.first(20)
      @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
    end
  end
  
  
  # ----------------- 利用規約
  def agreement
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
  end
  
  # ----------------- プライバシー
  def privacy
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
  end
  
  # ----------------- ヘルプ
  def help
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
  end
end
