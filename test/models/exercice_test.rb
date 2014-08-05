require 'test_helper'

class ExerciceTest < ActiveSupport::TestCase
  test "valid factory" do
    assert_equal true, FactoryGirl.build(:exercice).valid?
  end
end
