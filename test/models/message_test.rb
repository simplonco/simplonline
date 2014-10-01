require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "have a valid factory" do
    assert FactoryGirl.build(:message).valid?
  end

  test "invalid without user" do
    assert FactoryGirl.build(:message, user: nil).invalid?
  end

  test "invalid without status" do
    assert FactoryGirl.build(:message, status: nil).invalid?
  end

  test "can return user_name" do
    message = FactoryGirl.build(:message)
    user = message.user
    assert_equal user.name, message.user_name
  end

  test "recent" do
    today = DateTime.new(2013,12,23,14,57)
    message = FactoryGirl.create(:message, updated_at: today)
    old_message = FactoryGirl.create(:message, updated_at: today - 40.days)
    assert_equal [message], Message.recent(1)
  end

  test "have empty comments" do
    assert_equal [], Message.new.comments
  end
end
