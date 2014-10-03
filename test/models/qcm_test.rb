require 'test_helper'

class QcmTest < ActiveSupport::TestCase

  test "have a valid factory" do
    assert FactoryGirl.build(:qcm).valid?
  end

  test "invalid without lesson" do
    assert FactoryGirl.build(:qcm, lesson: nil).invalid?
  end

  test "invalid without authors" do
    assert FactoryGirl.build(:qcm, authors: []).invalid?
  end

  test "first_question" do
    qcm = FactoryGirl.create(:qcm)
    second_question = FactoryGirl.create(:question, position: 2, qcm: qcm)
    first_question = FactoryGirl.create(:question, position: 1, qcm: qcm)
    assert_equal first_question, qcm.first_question
  end
end
