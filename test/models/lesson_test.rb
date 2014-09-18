require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:lesson).valid?
  end

  test "invalid without title" do
    assert FactoryGirl.build(:lesson, title: nil).invalid?
  end

  test "invalid without publish date" do
    assert FactoryGirl.build(:lesson, publish_at: nil).invalid?
  end

  test "last_lesson" do
    lesson = FactoryGirl.create(:lesson)
    assert_equal [lesson], Lesson.last_lessons
  end

  test "exist without chapters" do
    lesson = FactoryGirl.create(:lesson)
    assert_equal [], lesson.chapters
  end

  test "exist without qcms" do
    lesson = FactoryGirl.create(:lesson)
    assert_equal [], lesson.qcms
  end

  test "exist without exercices" do
    lesson = FactoryGirl.create(:lesson)
    assert_equal [], lesson.exercices
  end
end
