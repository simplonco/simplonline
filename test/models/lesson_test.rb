require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:lesson).valid?
  end

  test "invalid without title" do
    assert FactoryGirl.build(:lesson, title: nil).invalid?
  end

  test "invalid without authors" do
    assert FactoryGirl.build(:lesson, authors: []).invalid?
  end

  test "offline by defaut" do
    assert FactoryGirl.build(:lesson).offline?
  end

  test "online when ask to be" do
    assert FactoryGirl.build(:lesson, online: true).online?
  end

  test "last_lesson about only online ones" do
    offline_lesson = FactoryGirl.create(:lesson, online: false)
    online_lesson = FactoryGirl.create(:lesson, online: true)
    assert_equal [online_lesson], Lesson.last_lessons
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

  test "online" do
    online_lesson = FactoryGirl.create(:lesson, online: true)
    offline_lesson = FactoryGirl.create(:lesson, online: false)
    assert_equal [online_lesson], Lesson.online
  end

  test "chapters order by number " do
    lesson = FactoryGirl.create(:lesson)
    second_chapter = FactoryGirl.create(:chapter, number: 2, lesson: lesson)
    first_chapter = FactoryGirl.create(:chapter, number: 0, lesson: lesson)
    assert_equal [first_chapter, second_chapter], lesson.chapters
  end
end
