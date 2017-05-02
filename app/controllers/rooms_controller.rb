class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @contact = Contact.new
    @q = Micropost.search(params[:q])
    @activities = PublicActivity::Activity.all.sort_by{|ms|ms.created_at}.reverse
  end
end
