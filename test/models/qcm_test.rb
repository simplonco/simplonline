require 'test_helper'

class QcmTest < ActiveSupport::TestCase

  test "have a valid factory" do
    assert FactoryGirl.build(:qcm).valid?
  end
end
