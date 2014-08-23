require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  test "valid factory" do
    FactoryGirl.build(:lesson).valid?
  end
end
