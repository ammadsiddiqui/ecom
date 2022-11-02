require "test_helper"

class Admin::SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_session_new_url
    assert_response :success
  end
end
