require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "valid artist" do
    artist = Artist.new
    artist.name = 'John'
    artist.data_quality = 'ehh'
    assert artist.valid?
  end

  test "valid artist 2" do
    artist = Artist.new(name: 'John', data_quality: 'ehh')
    assert artist.valid?
  end

  test "artist without name" do
    artist = Artist.new(data_quality: 'ehh')
    refute artist.valid?
  end

  test "artist without data quality" do
    artist = Artist.new(name: 'John')
    refute artist.valid?
  end

  test "valid artist save to Db" do
    artist = Artist.new(name: 'peter', data_quality: 'ehh')
    assert artist.save
  end

  test "artist should not save with no name" do
    artist = Artist.new(data_quality: 'ehh')
    assert !artist.save
  end

  test "artist should not save with no data quality" do
    artist = Artist.new(name: 'John')
    assert !artist.save
  end
end
