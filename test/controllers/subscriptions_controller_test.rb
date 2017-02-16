require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "create subscription" do
    post user_session_path, params: { user: {email: "eric@turtle.com", password: 'turtle'}}
    assert_difference('Subscription.count') do
      post '/subscriptions/1', params: {}, headers: {'HTTP_REFERER' => 'http://foo.com'}
    end
  end

  test "delete subscription" do
    post user_session_path, params: { user: {email: "eric@turtle.com", password: 'turtle'}}
    post '/subscriptions/4', params: {}, headers: {'HTTP_REFERER' => 'http://foo.com'}
    assert_difference('Subscription.count', -1) do
      delete '/subscriptions/4', params: {}, headers: {'HTTP_REFERER' => 'http://foo.com'}
    end
  end
end
