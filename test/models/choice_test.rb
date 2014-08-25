require 'test_helper'

class ChoiceTest < ActiveSupport::TestCase

  test "have valid factory" do
    assert FactoryGirl.build(:choice).valid?
  end

  test "invalid without question" do
    assert FactoryGirl.build(:choice, question: nil).invalid?
  end

end
