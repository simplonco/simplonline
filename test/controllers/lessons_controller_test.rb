require 'test_helper'

class LessonsControllerTest < ActionController::TestCase

  attr_reader :user

  def setup_with(student_type)
    @user = FactoryGirl.create(:user, student_type: student_type)
    session[:user_id] = user.id
  end

  test "index" do
    setup_with(User::LOCAL)
    lesson = FactoryGirl.create(:lesson)
    get :index
    assert_response :success
    assert_equal [lesson], assigns(:lessons)
  end

  test "index for remote show only online session" do
    setup_with(User::REMOTE)
    online_lesson = FactoryGirl.create(:lesson, online: true)
    offline_lesson = FactoryGirl.create(:lesson, online: false)
    get :index
    assert_response :success
    assert_equal [online_lesson], assigns(:lessons)
  end

  test "new" do
    setup_with(User::LOCAL)
    get :new
    assert_response :success
  end

  test "can go to new when remote student" do
    setup_with(User::REMOTE)
    get :new
    assert_redirected_to root_path
  end

  test "create" do
    setup_with(User::LOCAL)
    post :create, lesson: {title: 'Something new', author_ids: [user.id.to_s]}
    assert_redirected_to lessons_path
    assert_equal 'Something new', Lesson.first.title
  end

  test "edit" do
    setup_with(User::LOCAL)
    lesson = FactoryGirl.create(:lesson)
    get :edit, id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "update" do
    setup_with(User::LOCAL)
    lesson = FactoryGirl.create(:lesson, title: 'Perl', description: 'truc')
    post :update, id: lesson.id, lesson: {title: 'Python', description: "something other"}
    assert_redirected_to lesson_path(lesson)
    lesson.reload
    assert_equal 'Python', lesson.title
    assert_equal 'something other', lesson.description
    assert_equal true, lesson.offline?
  end

  test "show" do
    setup_with(User::LOCAL)
    lesson = FactoryGirl.create(:lesson)
    get :show, id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "show for remote only when online" do
    setup_with(User::REMOTE)
    lesson = FactoryGirl.create(:lesson, online: true)
    get :show, id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "cant show for remote when offline" do
    setup_with(User::REMOTE)
    lesson = FactoryGirl.create(:lesson, online: false)
    get :show, id: lesson.id
    assert_redirected_to root_path
  end

end
