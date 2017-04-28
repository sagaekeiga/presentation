module ClipsHelper
    #-------------------------clipリンク
    def user_clip(micropost_user, micropost)
      if user_signed_in?
            render 'clips/clip_links', micropost: micropost if !current_user?(micropost_user)
      end
    end
end
