require 'test_helper'

class SysemailTest < ActionMailer::TestCase
  test "sent" do
    mail = Sysemail.sent
    assert_equal "Sent", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
