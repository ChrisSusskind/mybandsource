require 'test_helper'

class ReviewsAssociationTest < ActionDispatch::IntegrationTest

  test "create review leaving_user/receiving_user association" do
    user = User.first
    user2 = User.second
    assert_difference('user.received_reviews.count', 1) do
      Review.create(receiving_user_id: user.id, leaving_user_id: user2.id)
    end
    assert_difference('user2.left_reviews.count', 1) do
      Review.create(receiving_user_id: user.id, leaving_user_id: user2.id)
    end
  end

  test "review deleted when leaving_user deleted" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    Review.create(receiving_user_id: user2.id, leaving_user_id: user.id)
    assert_difference('Review.all.size', -1) do
      user.destroy
    end
  end

  test "review deleted when receiving_user deleted" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    Review.create(receiving_user_id: user.id, leaving_user_id: user2.id)
    assert_difference('Review.all.size', -1) do
      user.destroy
    end
  end
end