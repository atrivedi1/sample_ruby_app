require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    
    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")

    # Ensure /users not accessible while logged out
    get users_path
    assert_redirected_to login_url

    # Ensure /users IS accessible when logged in
    get login_url
    assert_select "title", full_title("Log in")
    log_in_as(@user)
    assert_redirected_to users_path
  end
end