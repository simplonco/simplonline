require 'test_helper'

class StaticControllerTest < ActionController::TestCase

  test "welcome" do
    get 'welcome'
    assert_response :success
  end

  test "legal" do
    get 'legal'
    assert_response :success
  end

  test "contact" do
    get 'contact'
    assert_response :success
  end
end
