require 'test_helper'

class DefinitionTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:definition).valid?
  end

  test "invalid without keyword" do
    assert FactoryGirl.build(:definition, keyword: nil).invalid?
  end

  test "invalid without description" do
    assert FactoryGirl.build(:definition, description: nil).invalid?
  end

  test "last_updated" do
    definition = FactoryGirl.create(:definition)
    assert_equal [definition], Definition.last_updated
  end

  test "by_keyword" do
    b_def = FactoryGirl.create(:definition, keyword: 'bbb')
    a_def = FactoryGirl.create(:definition, keyword: 'aaa')
    assert_equal [a_def, b_def], Definition.by_keyword
  end

end


