class CommentsController < ApplicationController
    
    
    def create
      @comment = current_user.comments.build(comment_params)

      if @comment.save
        flash[:success] = "コメントを投稿しました。"
        redirect_to request.referrer || root_url
      else
        @feed_items = []
        redirect_to root_url
      end
    end
    
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      flash[:success] = "コメントを削除しました"
      redirect_to request.referrer || root_url
    end
    
    private
     def comment_params
         params.require(:comment).permit(:body, :user_id, :micropost_id)
     end
end
