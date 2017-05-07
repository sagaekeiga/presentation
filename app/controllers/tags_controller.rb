class TagsController < ApplicationController
    before_action :logged_in_user

    def new
        @tag = Tag.new
        @contact = Contact.new
        @q = Micropost.search(params[:q])
        @activities = PublicActivity::Activity.all
    end
    
    def create
          @tag = Tag.new(tag_params)
          if @tag.save
              redirect_to tags_path
          else
              render 'tags/new'
          end
    end
    
    def edit
        @q = Micropost.search(params[:q])
        @tag = Tag.find(params[:id])
        @contact = Contact.new
        @activities = PublicActivity::Activity.all
    end
    
    def update
      @tag = Tag.find(params[:id])
      if @tag.update(tag_params)
        redirect_to tags_path
      else
        render 'edit'
      end
    end
    
    def index
      @q = Micropost.search(params[:q])
      @contact = Contact.new
      @activities = PublicActivity::Activity.all
      @tags = Tag.all
    end
    
    private
    
     def tag_params
         params.require(:tag).permit(:name)
     end
end
