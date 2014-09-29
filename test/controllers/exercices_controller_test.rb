require 'test_helper'

class ExercicesControllerTest < ActionController::TestCase

  attr_reader :user

  def setup_with(student_type)
    @user = FactoryGirl.create(:user, student_type: student_type)
    session[:user_id] = @user.id
  end

  test "new" do
    setup_with(User::LOCAL)
    lesson = FactoryGirl.create(:lesson)
    get :new, lesson_id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "Remote student cant access to new" do
    setup_with(User::REMOTE)
    lesson = FactoryGirl.create(:lesson)
    get :new, lesson_id: lesson.id
    assert_redirected_to root_path
  end
end
