require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  test "should get reg" do
    get :reg
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

end
