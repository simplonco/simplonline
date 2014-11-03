require 'test_helper'

class ChapterTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:chapter).valid?
  end

  test "invalid without title" do
    assert FactoryGirl.build(:chapter, title: nil).invalid?
  end

  test "invalid without authors" do
    assert FactoryGirl.build(:chapter, authors: []).invalid?, 'should have at leat one author'
  end

  test "invalid without number" do
    assert FactoryGirl.build(:chapter, number: nil).invalid?, 'should have an number'
  end

  test "add definitions to chapter" do
    definition = FactoryGirl.create(:definition, keyword: "word")
    chapter = FactoryGirl.build(:chapter, content: "Word")
    chapter.insert_definitions!
    expected_content = "[Word](/definitions/#{definition.id})"
    assert_equal expected_content, chapter.content
  end

  test "insert definition" do
    definition = FactoryGirl.create(:definition, keyword: 'keyword')
    chapter = FactoryGirl.build(:chapter, content: "a content with some **keyword** that I wanna link to *definition*")
    chapter.insert_definitions!
    expected_content = "a content with some [**keyword**](/definitions/#{definition.id}) that I wanna link to *definition*"
    assert_equal expected_content, chapter.content
  end

  test "filter on tag" do
    tools_chapter = FactoryGirl.create(:chapter, tags: ['tools'])
    kata_chapter = FactoryGirl.create(:chapter, tags: ['kata'])
    assert_equal [kata_chapter], Chapter.about(:kata)
  end

  test "default sort by number" do
    second_chapter = FactoryGirl.create(:chapter, number: 1)
    first_chapter = FactoryGirl.create(:chapter, number: 0)
    assert_equal [first_chapter, second_chapter], Chapter.all
  end

  test "next" do
    lesson = FactoryGirl.create(:lesson)
    second_chapter = FactoryGirl.create(:chapter, number: 1, lesson: lesson)
    first_chapter = FactoryGirl.create(:chapter, number: 0, lesson: lesson)
    assert_equal second_chapter, first_chapter.next
    assert_equal nil, second_chapter.next
  end

  test "prev" do
    lesson = FactoryGirl.create(:lesson)
    second_chapter = FactoryGirl.create(:chapter, number: 1, lesson: lesson)
    first_chapter = FactoryGirl.create(:chapter, number: 0, lesson: lesson)
    assert_equal first_chapter, second_chapter.prev
    assert_equal nil, first_chapter.prev
  end

  test "prev_2" do
    lesson = FactoryGirl.create(:lesson)
    third_chapter = FactoryGirl.create(:chapter, number: 2, lesson: lesson)
    second_chapter = FactoryGirl.create(:chapter, number: 1, lesson: lesson)
    first_chapter = FactoryGirl.create(:chapter, number: 0, lesson: lesson)
    assert_equal second_chapter, third_chapter.prev
    assert_equal nil, first_chapter.prev
  end

  test "could have some submissions" do
    chapter = FactoryGirl.build(:chapter)
    assert_equal [], chapter.submissions
  end

  test "user_submission" do
    chapter = FactoryGirl.build(:chapter)
    user = FactoryGirl.create(:user)
    submission = FactoryGirl.create(:submission, chapter: chapter, user:user)
    other_submission = FactoryGirl.create(:submission, chapter: chapter)
    assert_equal submission, chapter.user_submission(user)
  end

  test "submissions_to_validate" do
    chapter = FactoryGirl.build(:chapter)

    submission_to_validate = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: false)

    validated_submission = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: true, second_validation_status: true)

    assert_equal [submission_to_validate], chapter.submissions_to_validate
  end
end


