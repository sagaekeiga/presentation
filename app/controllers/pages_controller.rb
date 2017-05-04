class PagesController < ApplicationController
  def index
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
    if user_signed_in?
      @microposts = Micropost.order("created_at DESC").page(params[:page])
      @tag_pops = Tag.all.sort_by{|ms|ms.frequency}.reverse.first(5)
      @tag_microposts = current_user.microposts.all
      
      @user_rank = User.all.order("score desc").first(10)
      calculate(current_user)
    end
  end
  
  
  def prototype
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
    
    @prototypes = Micropost.where(purpose: 1).order("created_at DESC").page(params[:prototype])
    @tag_pops = Tag.all.sort_by{|ms|ms.frequency}.reverse.first(5)
    @tag_microposts = current_user.microposts.all
    
    @user_rank = User.all.order("score desc").first(10)
    calculate(current_user)
  end
  
  def presentation
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
    
    @presentations = Micropost.where(purpose: 2).order("created_at DESC").page(params[:presentation])
    @tag_pops = Tag.all.sort_by{|ms|ms.frequency}.reverse.first(5)
    @tag_microposts = current_user.microposts.all
    
    @user_rank = User.all.order("score desc").first(10)
    calculate(current_user)
  end
  
  def rank
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
    
    @ranks = Micropost.order("rank DESC").page(params[:rank])
    @tag_pops = Tag.all.sort_by{|ms|ms.frequency}.reverse.first(5)
    @tag_microposts = current_user.microposts.all
    
    @user_rank = User.all.order("score desc").first(10)
    calculate(current_user)
  end
  
  def palace
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
    
    @palaces = Micropost.where(palace: true).order("created_at DESC").page(params[:palace])
    @tag_pops = Tag.all.sort_by{|ms|ms.frequency}.reverse.first(5)
    @tag_microposts = current_user.microposts.all
    
    @user_rank = User.all.order("score desc").first(10)
    calculate(current_user)
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
