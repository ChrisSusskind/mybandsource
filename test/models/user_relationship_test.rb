require 'test_helper'

class UserRelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user_1 = User.create(name: 'peter', email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @user_2 = User.create(name: 'peter', email: 'peter2@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    @user_relationship = UserRelationship.new(follower_id: @user_1.id, followed_id: @user_2.id)
  end

  test "should be valid" do
    assert @user_relationship.valid?
  end

  test "should require a follower_id" do
    @user_relationship.follower_id = nil
    assert_not @user_relationship.valid?
  end

  test "should require a followed_id" do
    @user_relationship.followed_id = nil
    assert_not @user_relationship.valid?
  end

  test "should follow and unfollow a user" do
    @user_relationship.follower_id = nil
    @user_relationship.followed_id = nil
    assert_not @user_1.following?(@user_2)

    @user_1.follow(@user_2)
    assert @user_1.following?(@user_2)
    assert @user_2.followers.include?(@user_1)

    @user_1.unfollow(@user_2)
    assert_not @user_1.following?(@user_2)
  end
end
