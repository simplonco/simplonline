require 'test_helper'

class ExercicesControllerTest < ActionController::TestCase

  attr_reader :user

  def setup
    @user = FactoryGirl.create(:user)
    session[:user_id] = user.id
  end

  test "new" do
    lesson = FactoryGirl.create(:lesson)
    get :new, lesson_id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

end
