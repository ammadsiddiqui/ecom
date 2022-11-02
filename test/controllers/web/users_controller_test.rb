require "test_helper"

class Web::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_users_index_url
    assert_response :success
  end
end
