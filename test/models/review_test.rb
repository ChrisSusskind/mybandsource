require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "invalid review w/ no associated user" do
    review = Review.new(artist_id: 1)
    assert !review.valid?
  end

  test "invalid review w/ no associated artist" do
    review = Review.new(user_id: 1)
    assert !review.valid?
  end

  test "should not save review with no associated user" do
    review = Review.new(artist_id: 1)
    assert !review.save
  end

  test "should not save review with no associated artist" do
    review = Review.new(user_id: 1)
    assert !review.save
  end
end
