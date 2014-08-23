require 'test_helper'

class LessonsControllerTest < ActionController::TestCase

  def setup
    user = FactoryGirl.create(:user)
  end

  test "index" do
    lesson = FactoryGirl.create(:lesson)
    get :index
    assert_response :success
    assert_equal [lesson], assigns(:lessons)
  end

end
