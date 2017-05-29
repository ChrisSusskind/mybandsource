require 'test_helper'

class UserRelationshipsAssociationTest < ActionDispatch::IntegrationTest
  test "create user relationship association" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    assert_difference('user.followers.count', 1) do
      UserRelationship.create(follower_id: user2.id, followed_id: user.id)
    end
    assert_difference('user.following.count', 1) do
      UserRelationship.create(follower_id: user.id, followed_id: user2.id)
    end
  end

  test "user relationship destroyed when follower destroyed" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    UserRelationship.create(follower_id: user.id, followed_id: user2.id)
    assert_difference('UserRelationship.all.size', -1) do
      user.destroy
    end
  end

  test "user relationship destroyed when followed destroyed" do
    user = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    user2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    UserRelationship.create(follower_id: user.id, followed_id: user2.id)
    assert_difference('UserRelationship.all.size', -1) do
      user2.destroy
    end
  end
end