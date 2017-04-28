module LikesHelper
    #-------------------------いいね！リンク
    def user_like(micropost_user, micropost)
      if user_signed_in?
            render 'likes/like_links', micropost: micropost if !current_user?(micropost_user)
      end
    end
end
