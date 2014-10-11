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

  test "invalid without title" do
    assert FactoryGirl.build(:message, title: nil).invalid?
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
    assert_equal [message, old_message], Message.recent
  end

  test "have empty responses" do
    assert_equal [], Message.new.responses
  end

  test "have one response" do
    message = FactoryGirl.create(:message)
    response = FactoryGirl.create(:message, parent: message)
    assert_equal [response], message.responses
  end

  test "responses are sorted by created_at" do
    today = DateTime.new(2013,8,23,14,49)
    message = FactoryGirl.create(:message, created_at: today)
    latest_response = FactoryGirl.create(:message, parent: message, created_at: today + 2.hours)
    response = FactoryGirl.create(:message, parent: message, created_at: today + 1.hour)
    assert_equal [response, latest_response], message.responses
  end

end
