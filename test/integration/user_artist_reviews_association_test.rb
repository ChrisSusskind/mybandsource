require 'test_helper'

class UserArtistReviewsAssociationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "create user review" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    assert_difference('user.reviews.count', 1) do
      user.reviews.create(artist_id: artist.id)
    end
  end

  test "link user review with artist" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    assert_difference('artist.reviews.count', 1) do
      user.reviews.create(artist_id: artist.id)
    end
  end

  test "review destroyed when associated user deleted" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    user.reviews.create(artist_id: artist.id)
    assert_difference('Review.all.size', -1) do
      user.destroy
    end
  end

  test "review destroyed when associated artist deleted" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    user.reviews.create(artist_id: artist.id)
    assert_difference('Review.all.size', -1) do
      artist.destroy
    end
  end
end
