require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:lesson).valid?
  end

  test "invalid without title" do
    assert FactoryGirl.build(:lesson, title: nil).invalid?
  end

  test "last_lesson" do
    lesson = FactoryGirl.create(:lesson)
    assert_equal [lesson], Lesson.last_lessons
  end
end
