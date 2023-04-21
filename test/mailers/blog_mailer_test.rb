require "test_helper"

class BlogMailerTest < ActionMailer::TestCase
  test "share_blog" do
    mail = BlogMailer.share_blog
    assert_equal "Share blog", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
