require 'test_helper'

class LessonsControllerTest < ActionController::TestCase

  def setup
    user = FactoryGirl.create(:user, remote: false)
    session[:user_id] = user.id
  end

  test "index" do
    lesson = FactoryGirl.create(:lesson)
    get :index
    assert_response :success
    assert_equal [lesson], assigns(:lessons)
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    post :create, lesson: {title: 'Something new'}
    assert_redirected_to lessons_path
    assert_equal 'Something new', Lesson.first.title
  end

  test "edit" do
    lesson = FactoryGirl.create(:lesson)
    get :edit, id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "show" do
    lesson = FactoryGirl.create(:lesson)
    get :show, id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

end
