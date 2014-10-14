require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:submission).valid?
  end

  test "invalid without content" do
    assert FactoryGirl.build(:submission, content: nil).invalid?
  end

  test "invalid without user" do
    assert FactoryGirl.build(:submission, user: nil).invalid?
  end

  test "invalid without chapter" do
    assert FactoryGirl.build(:submission, chapter: nil).invalid?
  end

  test "user_name extract from user name" do
    submission = FactoryGirl.build(:submission)
    user = submission.user
    assert_not_nil submission.user_name
    assert_equal user.name, submission.user_name
  end

  test "add_validation_from" do
    submission = FactoryGirl.build(:submission)
    validator = FactoryGirl.create(:user)

    submission.add_validation_from(validator, 'Something to say about submission', true)
    assert_equal validator, submission.first_validation_user
  end

  test "to_validate" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)

    to_validate = FactoryGirl.create(:submission)
    to_validate_by_just_one = FactoryGirl.create(:submission, first_validation_user: other_user)
    already_validated_by_me = FactoryGirl.create(:submission, first_validation_user: user)
    validated_by_me = FactoryGirl.create(:submission, first_validation_user: user, second_validation_user: other_user)
    validated = FactoryGirl.create(:submission, first_validation_user: FactoryGirl.create(:user), second_validation_user: other_user)

    assert_equal [to_validate, to_validate_by_just_one].sort, Submission.to_validate(user).sort
  end

  test "to_validate without one's that already validated by me" do
    user = FactoryGirl.create(:user)
    already_validated_by_me = FactoryGirl.create(:submission, first_validation_user: user)
    assert_equal [], Submission.to_validate(user)
  end

  test "missing_validations" do
    sub = FactoryGirl.create(:submission)
    assert_equal 2, sub.missing_validations

    sub = FactoryGirl.create(:submission, first_validation_user: FactoryGirl.create(:user))
    assert_equal 1, sub.missing_validations

    sub = FactoryGirl.create(:submission, first_validation_user: FactoryGirl.create(:user), second_validation_user: FactoryGirl.create(:user))
    assert_equal 0, sub.missing_validations
  end
end
