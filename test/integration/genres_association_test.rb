require 'test_helper'

class GenresAssociationTest < ActionDispatch::IntegrationTest
  test "create_user_genre_association" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    genre = Genre.create(name: "notevenmusic")
    assert_difference('genre.users.count', 1) do
      genre.users << user
    end
  end

  test "create_user_genre_association_pt2" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    genre = Genre.create(name: "notevenmusic")
    user.genre = genre
    assert user.genre == genre
  end
end