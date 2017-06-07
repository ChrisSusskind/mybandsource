require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "invalid reviews" do
    review = Review.new
    review2 = Review.new
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')

    # Empty review
    refute review.valid?

    #Review missing leaving_user_id
    review.receiving_user_id = @user.id
    refute review.valid?

    #Review missing receiving_user_id
    review2.leaving_user_id = @user.id
    refute review2.valid?
  end

  test "valid review" do
    review = Review.new
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    review.receiving_user_id = @user.id
    review.leaving_user_id = @user2.id
    assert review.valid?
    assert review.save
    assert review.destroy
  end
end
