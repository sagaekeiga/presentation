class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @contact = Contact.new
  end
end
