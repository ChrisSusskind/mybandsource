require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.find_by(email: 'eric@turtle.com')
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get user registration page" do

     get new_user_registration_path
     assert_response :success
  end

  test "should register user" do
    assert_difference('User.count') do
      post user_registration_path, params: { user: {name: 'Peter', email: 'test@test.com', password: 'password', password_confirmation: 'password'} }
    end
    assert_redirected_to root_path
  end

  test "should get user login page" do
    get new_user_session_path
    assert_response :success
  end

  test "should login in user" do
    old_user_sign_in_count = @user.sign_in_count
    post user_session_path, params: { user: {email: @user.email, password: 'turtle'}}
    @user.reload
    assert_not_equal old_user_sign_in_count, @user.sign_in_count
    assert_redirected_to root_path
  end

  test "should get edit for logged in user" do
    post user_session_path, params: { user: {email: @user.email, password: 'turtle'}}
    get edit_user_registration_path (@user)
    assert_response :success
  end

  test "should not get edit page for non-logged in user" do
    get edit_user_registration_path (@user)
    assert_response 401
  end

  ###THESE TESTS DON'T WORK.  Getting ActionController::UnknownFormat Error

  test "should update user location" do
   post user_session_path, params: { user: {email: @user.email, password: 'turtle'}}
   put user_registration_path, params: { user: { location: 'FUCK OFF', password: 'turtle' }, commit: :update }
   assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    post user_session_path, params: { user: {email: @user.email, password: 'turtle'}}
    delete user_registration_path
    assert_redirected_to root_path
  end
end
