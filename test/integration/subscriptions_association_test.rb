require 'test_helper'

class SubscriptionsAssociationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "user subscribes to an artist successfully" do
    user = User.create(email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    user.artists << artist
    assert_equal 1, user.artists.size
  end

  test "artist can get subscribers" do
    user = User.create(email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    user.artists << artist
    assert_equal 1, artist.users.size
  end

  test "user unsubscribes from an artist successfully" do
    user = User.create(email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    user.artists << artist
    user.artists.delete(artist)
    assert_equal 0, user.artists.size
  end

  test "user removed from artist following list when account deleted" do
    user = User.create(email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    user.artists << artist
    user.destroy
    assert_equal 0, artist.users.size
  end
end