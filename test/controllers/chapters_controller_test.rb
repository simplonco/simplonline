require 'test_helper'

class ChaptersControllerTest < ActionController::TestCase

  attr_reader :user, :lesson

  def setup
    @lesson = FactoryGirl.create(:lesson, online: true)
  end

  def setup_with(student_type)
    @user = FactoryGirl.create(:user, student_type: student_type)
    session[:user_id] = @user.id
  end

  test "new" do
    setup_with(User::LOCAL)
    get :new, lesson_id: lesson
    assert_response :success
    assert_equal lesson, assigns(:lesson)
    assert_equal [user], assigns(:available_authors)
    assert_equal Chapter::Tags, assigns(:available_tags)
  end

  test "can go to new when remote student" do
    setup_with(User::REMOTE)
    get :new, lesson_id: lesson
    assert_redirected_to root_path
  end

  test "create" do
    setup_with(User::LOCAL)
    post :create, lesson_id: lesson, chapter: {title: 'something', content: 'Once uppon a time, there was a big story that never end', author_ids: [user.id.to_s]}
    assert_redirected_to lesson_chapter_path(lesson, Chapter.first)
    assert_equal 1, Chapter.count
    assert_equal 1, lesson.reload.chapters.count
  end

  test "edit" do
    setup_with(User::LOCAL)
    chapter = FactoryGirl.create(:chapter, lesson: lesson)
    get :edit, lesson_id: lesson, id: chapter.id
    assert_response :success
    assert_equal chapter, assigns(:chapter)
    assert_equal lesson, assigns(:lesson)
    assert_equal [user], assigns(:available_authors)
    assert_equal Chapter::Tags, assigns(:available_tags)
  end

  test "update" do
    setup_with(User::LOCAL)
    chapter = FactoryGirl.create(:chapter, content: 'something', lesson: lesson)
    post :update, lesson_id: lesson, id: chapter.id, chapter: {content: 'something other'}
    assert_redirected_to lesson_chapter_path(lesson, chapter)
    assert_equal 'something other', chapter.reload.content
  end

  test "redirect remote when lesosn is offline" do
    setup_with(User::REMOTE)
    lesson = FactoryGirl.create(:lesson, online: false)
    chapter = FactoryGirl.create(:chapter, lesson: lesson)
    get :show, lesson_id: lesson, id: chapter.id
    assert_redirected_to root_path
  end

  test "show chapter to remote" do
    setup_with(User::REMOTE)
    chapter = FactoryGirl.create(:chapter, lesson: lesson)
    get :show, lesson_id: lesson, id: chapter.id
    assert_response :success
    assert_equal chapter, assigns(:chapter)
    assert_equal lesson, assigns(:lesson)
  end


end
