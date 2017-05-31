require 'test_helper'

class GenresAssociationTest < ActionDispatch::IntegrationTest
  test "create_user_genre_association" do
    user = User.first
    genre = Genre.first
    assert_difference('genre.users.count', 1) do
      genre.users << user
    end
  end
end