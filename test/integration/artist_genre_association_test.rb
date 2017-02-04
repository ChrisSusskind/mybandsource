require 'test_helper'

class ArtistGenreAssociationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "artist can specify genre" do
    artist = Artist.create(name: 'John', data_quality: 'ehh')
    rap = Genre.create(name: 'rap')
    rap.artists << artist
    assert_equal 'rap', artist.genre.name
  end

  test "can get artists in a genre" do
    artist1 = Artist.create(name: 'Peter', data_quality: 'ehh')
    artist2 = Artist.create(name: 'Paul', data_quality: 'ehh')
    rap = Genre.create(name: 'rap')
    rap.artists << artist1 << artist2
    assert_equal 2, rap.artists.size
  end

  test "deleted artist removed from genre" do
    artist1 = Artist.create(name: 'Peter', data_quality: 'ehh')
    artist2 = Artist.create(name: 'Paul', data_quality: 'ehh')
    rap = Genre.create(name: 'rap')
    rap.artists << artist1 << artist2
    artist1.destroy
    assert_equal 1, rap.artists.size
  end

end
