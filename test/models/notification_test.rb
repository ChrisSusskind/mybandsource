require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "invalid notification" do
    notification = Notification.new
    notification2 = Notification.new
    notification3 = Notification.new
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')

    # Empty notification
    refute notification.valid?

    # Notification missing receiving_user_id
    notification.generating_user_name = "Eric"
    notification.generating_user_id = @user.id
    refute notification.valid?

    # Notification missing generating_user_id
    notification2.generating_user_name = "Eric"
    notification2.receiving_user_id = @user.id
    refute notification2.valid?

    # Notification missing generating_user_name
    notification3.generating_user_id = @user.id
    notification3.receiving_user_id = @user.id
    refute notification3.valid?

  end

  test "valid following notification" do
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
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
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @artist = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx', is_artist: true)
    @review = Review.create(receiving_user_id: @user.id, leaving_user_id: @artist.id)
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
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @artist = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx', is_artist: true)
    @response = Response.new
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
