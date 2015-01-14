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
    user = FactoryGirl.create(:user)
    chapter = FactoryGirl.build(:chapter)

    submission_to_validate = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: false)

    validated_submission = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: true, second_validation_status: true)

    assert_equal [submission_to_validate], chapter.submissions_to_validate(user)
  end

  test "submissions_to_validate contains second_validation needed" do
    user = FactoryGirl.create(:user)
    chapter = FactoryGirl.build(:chapter)

    submission_to_validate = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: true, first_validation_user: FactoryGirl.create(:user))

    validated_submission = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: true, second_validation_status: true)

    assert_equal [submission_to_validate], chapter.submissions_to_validate(user)
  end

  test "My validated sub dont come with sub to validate" do
    user = FactoryGirl.create(:user)
    chapter = FactoryGirl.build(:chapter)

    submission_to_validate = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: true)
    already_validated = FactoryGirl.create(:submission, chapter: chapter, first_validation_status: true, first_validation_user: user)
    assert_equal [submission_to_validate], chapter.submissions_to_validate(user)
  end

  test "delete submission when delete chapter" do
    chapter = FactoryGirl.create(:chapter)
    submission = FactoryGirl.create(:submission, chapter: chapter)
    chapter.destroy
    assert_equal 0, Submission.count
  end

  test "delete submission when chapter stop ask for pair validation" do
    chapter = FactoryGirl.create(:chapter, ask_pair_validation: true)
    submission = FactoryGirl.create(:submission, chapter: chapter)
    chapter.ask_pair_validation = false
    chapter.save!
    assert_equal 0, Submission.count
  end

  test "validated_submission" do
    user = FactoryGirl.create(:user)
    chapter = FactoryGirl.create(:chapter)
    validated_sub = FactoryGirl.create(:submission, user: user, chapter: chapter, first_validation_user: FactoryGirl.create(:user), first_validation_status: true)
    assert_equal [validated_sub], chapter.validated_submissions(user)
  end

  test "user can validate other sub when self already validated" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    chapter = FactoryGirl.create(:chapter)
    FactoryGirl.create(:submission, user: user, chapter: chapter, first_validation_status: true, second_validation_status: true)
    assert chapter.user_submission_validated?(user), "user can validate other submissions only when self have been validated"
  end

  test "user cant validate other sub when self not yet validated" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    chapter = FactoryGirl.create(:chapter)
    FactoryGirl.create(:submission, user: user, chapter: chapter, first_validation_status: true, second_validation_status: false)
    assert ! chapter.user_submission_validated?(user), "user can validate other submissions only when self have been validated"
  end

  test "search return result when query matches" do
    tools_chapter = FactoryGirl.create(:chapter, title: 'tools', content: 'There are many tools you can use in programming.')
    kata_chapter = FactoryGirl.create(:chapter, title: 'kata', content: 'How to begin your first kata.')
    assert_equal [kata_chapter], Chapter.search('kata')
  end

  test "search return nil when no match with query" do
    tools_chapter = FactoryGirl.create(:chapter, title: 'tools', content: 'There are many tools you can use in programming.')
    kata_chapter = FactoryGirl.create(:chapter, title: 'kata', content: 'How to begin your first kata.')
    assert_equal [], Chapter.search('foo')
  end

end
