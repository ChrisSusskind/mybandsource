require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "invalid notification" do
    notification = Notification.new
    notification2 = Notification.new
    @user = User.first
    @user2 = User.second
    refute notification.valid?
    notification.generating_user_name = "Eric"
    notification.generating_user_id = @user.id
    refute notification.valid?
    notification2.generating_user_name = "Eric"
    notification2.receiving_user_id = @user.id
    refute notification2.valid?
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

  test "valid review notification" do
    @user = User.first
    @artist = User.artists.second
    @review = Review.first
    notification = Notification.new
    notification.generating_user_id = @user.id
    notification.generating_user_name = "Eric"
    notification.receiving_user_id = @artist.id
    notification.review_id = @review.id
    notification.notification_type = "review"
    assert notification.valid?
    assert notification.save
    assert notification.destroy
  end

  test "valid response notification" do
    @user = User.first
    @artist = User.artists.second
    @response = Response.first
    notification = Notification.new
    notification.generating_user_id = @user.id
    notification.generating_user_name = "Eric"
    notification.receiving_user_id = @artist.id
    notification.response_id = @response.id
    notification.notification_type = "response"
    assert notification.valid?
    assert notification.save
    assert notification.destroy
  end
end
