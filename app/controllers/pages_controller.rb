class PagesController < ApplicationController
  def index
    @microposts = Micropost.all
  end
  
end
