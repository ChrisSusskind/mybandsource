require 'test_helper'

class ResponsesAssociationTest < ActionDispatch::IntegrationTest
  test "create response review/user association" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    review = Review.create(receiving_user_id: user.id, leaving_user_id: user.id)
    assert_difference('review.responses.count', 1) do
      Response.create(comment: "Test", user_id: user.id, review_id: review.id)
    end
    assert_difference('user.responses.count', 1) do
      Response.create(comment: "Test", user_id: user.id, review_id: review.id)
    end
  end

  test "response deleted when user deleted" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    user2 = User.first
    review = Review.create(receiving_user_id: user.id, leaving_user_id: user2.id)
    Response.create(comment: "Test", user_id: user.id, review_id: review.id)
    assert_difference('Response.all.size', -1) do
      review.destroy
    end
  end

  test "repsonse deleted when review deleted" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    user2 = User.first
    review = Review.create(receiving_user_id: user.id, leaving_user_id: user2.id)
    Response.create(comment: "Test", user_id: user.id, review_id: review.id)
    assert_difference('Response.all.size', -1) do
      user.destroy
    end
  end
end