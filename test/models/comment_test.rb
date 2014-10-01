require 'test_helper'

class CommntTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:comment).valid?
  end

  test "invalid without user" do
    assert FactoryGirl.build(:comment, user: nil).invalid?
  end

  test "invalid without status" do
    assert FactoryGirl.build(:comment, status: nil).invalid?
  end

  test "invalid without message" do
    assert FactoryGirl.build(:comment, message: nil).invalid?
  end

  test "user_name" do
    comment = FactoryGirl.build(:comment)
    user = comment.user
    assert_equal user.name, comment.user_name
  end
end
