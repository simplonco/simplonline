require 'test_helper'

class QcmsControllerTest < ActionController::TestCase

  test "new" do
    lesson = FactoryGirl.create(:lesson)
    get :new, lesson_id: lesson.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
  end

  test "create" do
    lesson = FactoryGirl.create(:lesson)
    post :create, lesson_id: lesson.id, qcm: {title: 'something', description: 'a ubber qcm from nowhere'}
    assert_redirected_to new_lesson_qcm_question_path(lesson, Qcm.first)
    assert_equal 1, Qcm.count
  end

  test "edit" do
    qcm = FactoryGirl.create(:qcm)
    lesson = qcm.lesson
    get :edit, lesson_id: lesson.id, id: qcm.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
    assert_equal qcm, assigns(:qcm)
  end

  test "update" do
    qcm = FactoryGirl.create(:qcm, title: 'something')
    lesson = qcm.lesson
    post :update, id: qcm.id, lesson_id: lesson.id, qcm: {title: 'other'}
    assert_redirected_to lesson_qcm_path(lesson, qcm)
    assert_equal 'other', qcm.reload.title
  end

  test "show" do
    qcm = FactoryGirl.create(:qcm)
    lesson = qcm.lesson
    get :show, lesson_id: lesson.id, id: qcm.id
    assert_response :success
    assert_equal lesson, assigns(:lesson)
    assert_equal qcm, assigns(:qcm)
  end
end
