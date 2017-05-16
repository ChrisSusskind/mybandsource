require 'test_helper'

class ArtistGenreAssociationTest < ActionDispatch::IntegrationTest
  test "create_user_notification_association" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    assert_difference('user.notifications.count', 1) do
      Notification.create(generating_user_id: user.id, receiving_user_id: user.id, notification_type: 'follow', generating_user_name: "Test")
    end
  end

  test "create_artist_notification_association" do
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    assert_difference('artist.notifications.count', 1) do
      Notification.create(generating_user_id: user.id, receiving_artist_id: artist.id, notification_type: 'follow', generating_user_name: "Test")
    end
  end

  test "notification destroyed when receiving user destroyed" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    Notification.create(generating_user_id: user.id, receiving_user_id: user.id, notification_type: 'follow', generating_user_name: "Test")
    assert_difference('Notification.all.size', -1) do
      user.destroy
    end
  end

  test "notification destroyed when receiving artist destroyed" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    Notification.create(generating_user_id: user.id, receiving_artist_id: artist.id, notification_type: 'follow', generating_user_name: "Test")
    assert_difference('Notification.all.size', -1) do
      artist.destroy
    end
  end

  test "notification destroyed when associated review destroyed" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    review = Review.create(user_id: user.id, artist_id: artist.id)
    Notification.create(generating_user_id: user.id, receiving_artist_id: artist.id, review_id: review.id, notification_type: 'review', generating_user_name: "Test")
    assert_difference('Notification.all.size', -1) do
      review.destroy
    end
  end

  test "notification destroyed when associated response destroyed" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    review = Review.create(user_id: user.id, artist_id: artist.id)
    response = Response.create(user_id: user.id, review_id: review.id, comment: "Testing")
    Notification.create(generating_user_id: user.id, receiving_artist_id: artist.id, response_id: response.id, notification_type: 'response', generating_user_name: "Test")
    assert_difference('Notification.all.size', -1) do
      response.destroy
    end
  end
end