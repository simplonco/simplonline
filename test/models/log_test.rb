require 'test_helper'

class LogTest < ActiveSupport::TestCase

  test "invalid without trace" do
    log = Log.new
    assert log.invalid?, 'Invalid without trace'
    log.trace = 'a trace'
    assert log.valid?, 'Valid with trace'
  end

  test "create_for user" do
    user = FactoryGirl.create(:user)
    Log.create_for(user)
    assert_equal JSON.generate({user_id: user.id}), Log.first.trace
  end
end
