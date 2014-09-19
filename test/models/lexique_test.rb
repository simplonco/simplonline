require 'test_helper'

class LexiqueTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:chapter).valid?
  end

  test "invalid without title" do
    assert FactoryGirl.build(:chapter, keyword: nil).invalid?
  end

  test "invalid without authors" do
    # assert FactoryGirl.build(:chapter, authors: []).invalid?
  end
end


