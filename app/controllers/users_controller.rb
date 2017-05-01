class UsersController < ApplicationController
    def index
      @users = User.all
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
    end
    
    def show
      @user = User.find(params[:id])
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
    end
    
    def update
      p user_params
      respond_to do |format|
        if @user.update_without_current_password(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
end
