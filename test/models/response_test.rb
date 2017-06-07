require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "invalid response" do
    response = Response.new
    response2 = Response.new
    response3 = Response.new
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @review = Review.create(receiving_user_id: @user.id, leaving_user_id: @user.id)

    # Empty response
    refute response.valid?

    # Response missing review_id
    response.comment = "Hey"
    response.user_id = @user.id
    refute response.valid?

    # Response missing user_id
    response2.comment = "Hey"
    response2.review_id = @review.id
    refute response2.valid?

    # Response missing comment
    response3.user_id = @user.id
    response3.review_id = @review.id
    refute response3.valid?
  end

  test "valid response" do
    response = Response.new
    @user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @review = Review.create(receiving_user_id: @user.id, leaving_user_id: @user.id)
    response.comment = "Hey"
    response.user_id = @user.id
    response.review_id = @review.id
    assert response.valid?
    assert response.save
    assert response.destroy
  end

  test "valid response has correct defaults" do
    response = Response.new
    assert response.upvotes == 0
    assert response.upvotes_userlist == []
  end
end
