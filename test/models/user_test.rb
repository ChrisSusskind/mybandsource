require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "valid user save to DB" do
    user = User.new(email: 'peter@test.com', password: 'xxxxxxx', password_confirmation: 'xxxxxxx')
    assert user.save
  end

  test "user should not save with no email" do
    user = User.new(encrypted_password: 'xxx')
    assert !user.save
  end

  test "user should not save with no encrypted password" do
    user = User.new(email: 'peter@test.com')
    assert !user.save
  end
end
