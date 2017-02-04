require 'test_helper'

class GenreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "valid genre" do
    genre = Genre.new
    genre.name = 'rap'
    assert genre.valid?
  end

  test "valid genre 2" do
    genre = Genre.new(name: 'rap')
    assert genre.valid?
  end

  test "genre without name" do
    genre = Genre.new
    assert !genre.valid?
  end

  test "valid genre save to Db" do
    genre = Genre.new(name: 'rap')
    assert genre.save
  end

  test "genre should not save with no name" do
    genre = Genre.new
    assert !genre.save
  end
end
