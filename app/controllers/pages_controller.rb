class PagesController < ApplicationController
  before_action :logged_in_user, :except => ['index']

  def index
    bar_option
    twitter_client
    @chart_data = [["7日前" , 60], ["6日前", 65], ["5日前", 64], ["4日前" , 60], ["3日前", 65], ["2日前", 64], ["1日前", 64]]
    if user_signed_in?
      page_index
      @microposts = Micropost.order("created_at DESC").page(params[:page])
    end
  end
  
  
  def prototype
    page_index
    @prototypes = Micropost.where(purpose: 1).order("created_at DESC").page(params[:prototype])
  end
  
  def presentation
    page_index
    @presentations = Micropost.where(purpose: 2).order("created_at DESC").page(params[:presentation])
  end
  
  def rank
    page_index
    @ranks = Micropost.order("rank DESC").page(params[:rank])
  end
  
  def palace
    page_index
    @palaces = Micropost.where(palace: true).order("created_at DESC").page(params[:palace])
  end
  
  def notice_index
    page_index
  end
  
  
  # ----------------- 利用規約
  def agreement
    bar_option
  end
  
  # ----------------- プライバシー
  def privacy
    bar_option
  end
  
  # ----------------- ヘルプ
  def help
    bar_option
  end
  
  def about
    bar_option
  end
  
  def secret
    bar_option
  end
end
