require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:"",
                                  email: "user@invalid",
                                  password: "foo",
                                  password_confirmation: "Bar"}}
    end
    assert_template 'users/new'
  end
  
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: {name: "Example User",
                                  email: "Example@example.com",
                                  password: "Foobar",
                                  password_confirmation: "Foobar"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
  
end