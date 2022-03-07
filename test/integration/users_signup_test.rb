require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'Invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: " ", email: "tony@example", password: "pass", password_confirmation: "word"}}
    end

    assert_template 'users/new'
  end

  test 'Valid signup information' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: {user: {name: "Tony", email: "tony@example.com", password: "password123", password_confirmation: "password123"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
