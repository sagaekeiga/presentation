class ApplicationMailer < ActionMailer::Base
  default from:     "Ruppish【ラピッシュ】",
          bcc:      "sagae5.28rujeae@gmail.com",
          reply_to: "sagae5.28rujeae@gmail.com"
  layout 'mailer'
end

