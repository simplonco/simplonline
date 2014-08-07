require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid factory" do
    assert_equal true, FactoryGirl.build(:user).valid?
  end

end
