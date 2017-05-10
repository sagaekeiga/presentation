# Preview all emails at http://localhost:3000/rails/mailers/notice_mail_mailer
class NoticeMailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice_mail_mailer/post_email
  def post_email
    NoticeMailMailer.post_email
  end

end
