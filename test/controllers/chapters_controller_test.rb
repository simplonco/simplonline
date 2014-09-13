require 'test_helper'

class ChaptersControllerTest < ActionController::TestCase

  def setup
    user = FactoryGirl.create(:user)
    session[:user_id] = user.id
  end

  test "new" do
    lesson = FactoryGirl.create(:lesson)
    get :new, lesson_id: lesson
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "create" do
    lesson = FactoryGirl.create(:lesson)
    post :create, lesson_id: lesson, chapter: {title: 'something', content: 'Once uppon a time, there was a big story that never end'}
    assert_redirected_to edit_lesson_path(lesson)
    assert_equal 1, Chapter.count
    assert_equal 1, lesson.reload.chapters.count
  end

  test "edit" do
    chapter = FactoryGirl.create(:chapter)
    lesson = chapter.lesson
    get :edit, lesson_id: lesson, id: chapter.id
    assert_response :success
    assert_equal chapter, assigns(:chapter)
    assert_equal lesson, assigns(:lesson)
  end

  test "update" do
    chapter = FactoryGirl.create(:chapter, content: 'something')
    lesson = chapter.lesson
    post :update, lesson_id: lesson, id: chapter.id, chapter: {content: 'something other'}
    assert_redirected_to lesson_chapter_path(chapter, lesson)
    assert_equal 'something other', chapter.reload.content
  end



  test "show" do
    chapter = FactoryGirl.create(:chapter)
    lesson = chapter.lesson
    get :show, lesson_id: lesson, id: chapter.id
    assert_response :success
    assert_equal chapter, assigns(:chapter)
    assert_equal lesson, assigns(:lesson)
  end
end
