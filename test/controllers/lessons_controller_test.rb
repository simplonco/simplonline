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
    post :create, lesson: {title: 'Something new', publish_at: '2014-12-13'}
    assert_redirected_to lessons_path
    assert_equal 'Something new', Lesson.first.title
  end

  test "edit" do
    lesson = FactoryGirl.create(:lesson)
    get :edit, id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "update" do
    lesson = FactoryGirl.create(:lesson, title: 'Perl', description: 'truc', publish_at: '1/2/2013')
    post :update, id: lesson.id, lesson: {title: 'Python', description: "something other", publish_at: '30/02/2014 14h56'}
    assert_redirected_to lesson_path(lesson)
    lesson.reload
    assert_equal 'Python', lesson.title
    assert_equal 'something other', lesson.description
    assert_equal Time.new(2014,2,30,14,56), lesson.publish_at
  end

  test "show" do
    lesson = FactoryGirl.create(:lesson)
    get :show, id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

end
