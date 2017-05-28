require 'test_helper'

class ArtistGenreAssociationTest < ActionDispatch::IntegrationTest
  test "create_user_notification_association" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    assert_difference('user.notifications.count', 1) do
      Notification.create(generating_user_id: user.id, receiving_user_id: user.id, notification_type: 'follow', generating_user_name: "Test")
    end
  end

  test "notification destroyed when receiving user destroyed" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    Notification.create(generating_user_id: user.id, receiving_user_id: user.id, notification_type: 'follow', generating_user_name: "Test")
    assert_difference('Notification.all.size', -1) do
      user.destroy
    end
  end
end