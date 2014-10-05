require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "current_user is allowed to delete his messages" do
    message = FactoryGirl.create(:message)
    user = message.user
    assert change_allowed?(message, user), "message's author can delete or update his own message"
  end

  test "user is not allowed to delete other's messages" do
    message = FactoryGirl.create(:message)
    user = FactoryGirl.create(:user)
    assert ! change_allowed?(message, user), "user cant delete or update other's messages"
  end

  test "staf's user are allowed to delete other's messages" do
    message = FactoryGirl.create(:message)
    user = FactoryGirl.create(:user, student_type: User::STAFF)
    assert change_allowed?(message, user), "staff users can delete or update other's messages"
  end

end
