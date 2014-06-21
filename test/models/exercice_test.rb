require 'test_helper'

class ExerciceTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "enonce exist" do
    assert_equal "a", exercices(:one).consigne 
  end
end
