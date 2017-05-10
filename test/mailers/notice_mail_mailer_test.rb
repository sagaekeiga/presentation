require 'test_helper'

class NoticeMailMailerTest < ActionMailer::TestCase
  test "post_email" do
    mail = NoticeMailMailer.post_email
    assert_equal "Post email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
