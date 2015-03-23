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

  test "search return result when query matches" do
    tools_message = FactoryGirl.create(:message, title: 'tools', content: 'There are too many tools to use in programming.')
    kata_message = FactoryGirl.create(:message, title: 'kata', content: 'How do I begin my first kata?')
    assert_equal [kata_message], Message.search('kata')
  end

  test "search return result when query matches one word in title and another word in content" do
    kata_tools_message = FactoryGirl.create(:message, title: 'kata', content: 'Do you know programming tools?')
    kata_message = FactoryGirl.create(:message, title: 'kata', content: 'How to start a kata?')
    assert_equal [kata_tools_message], Message.search('kata tools')
  end

  test "search return nil when no match with query" do
    tools_message = FactoryGirl.create(:message, title: 'tools', content: 'There are too many tools to use in programming.')
    kata_message = FactoryGirl.create(:message, title: 'kata', content: 'How do I begin my first kata?')
    assert_equal [], Message.search('foo')
  end

  test "users to notify" do
    parent_message = FactoryGirl.create(:message)
    message = FactoryGirl.create(:message, parent: parent_message)
    user = parent_message.user
    assert_equal [user], message.users_to_notify
  end

  test "users to notify without duplicate" do
    grand_parent_message = FactoryGirl.create(:message)
    user = grand_parent_message.user
    parent_message = FactoryGirl.create(:message, user: user, parent: grand_parent_message)
    message = FactoryGirl.create(:message, parent: parent_message)
    assert_equal [user], message.users_to_notify
  end
end
