require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "invalid notification" do
    notification = Notification.new
    refute notification.valid?
  end

  test "valid following notification" do
    notification = Notification.new
    notification.generating_user_id = 1
    notification.generating_user_name = "Eric"
    notification.receiving_user_id = 2
    notification.notification_type = "follow"
    assert notification.valid?
    assert notification.save
    assert notification.destroy
  end

  test "valid review notification" do
    notification = Notification.new
    notification.generating_user_id = 1
    notification.generating_user_name = "Eric"
    notification.receiving_artist_id = 1
    notification.notification_type = "review"
    assert notification.valid?
    assert notification.save
    assert notification.destroy
  end

  test "valid response notification" do
    notification = Notification.new
    notification.generating_user_id = 1
    notification.generating_user_name = "Eric"
    notification.receiving_artist_id = 1
    notification.notification_type = "response"
    assert notification.valid?
    assert notification.save
    assert notification.destroy
  end

end
