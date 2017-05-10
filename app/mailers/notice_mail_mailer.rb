class NoticeMailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mail_mailer.post_email.subject
  #
  def post_email(user, opponent, type, url)
    @user = user
    @url = url
    @opponent = opponent
    @type = type
    
    if type == "like"
      mail to:      opponent.email,
           subject: "#{@user.name}さんが#{@opponent.name}さんの記事を評価しました。"
    elsif type == "comment"
      mail to:      opponent.email,
           subject: "#{@user.name}さんが#{@opponent.name}さんの記事にコメントしました。"
    elsif type == "clip"
      mail to:      opponent.email,
           subject: "#{@user.name}さんが#{@opponent.name}さんの記事をクリップしました。"
    elsif type == "follow"
      mail to:      opponent.email,
           subject: "#{@user.name}さんが#{@opponent.name}さんをフォローしました。"
    end
  end
end
