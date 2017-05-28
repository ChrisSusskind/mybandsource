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
    @user = User.first
    @user2 = User.second
    notification = Notification.new
    notification.generating_user_id = @user.id
    notification.generating_user_name = "Eric"
    notification.receiving_user_id = @user2.id
    notification.notification_type = "follow"
    assert notification.valid?
    assert notification.save
    assert notification.destroy
  end
end
