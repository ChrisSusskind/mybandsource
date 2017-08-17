require 'test_helper'

class ClaimMailerTest < ActionMailer::TestCase

  test 'claim' do
    email = ClaimMailer.claim_email('Bobby Bakala', 'bobbybakala@sopranos.com')
    assert_emails 1 do
      email.deliver_now
    end
  end
end
