module ApplicationHelper
    def date_format(datetime)
        time_ago_in_words(datetime) + '前'
    end
    
  def gravatar_for(user, size = 80, secure = true)
    Gravatar.new(user.email).image_url(size: size, secure: secure)
  end
  
  def qiita_markdown(markdown)
    processor = Qiita::Markdown::Processor.new(hostname: "example.com")
    processor.call(markdown)[:output].to_s.html_safe
  end
end
