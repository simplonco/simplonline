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
end
