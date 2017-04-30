module ApplicationHelper
    def date_format(datetime)
        time_ago_in_words(datetime) + '前'
    end
    
  def gravatar_for(user, size = 80, secure = true)
    Gravatar.new(user.email).image_url(size: size, secure: secure)
  end
end
