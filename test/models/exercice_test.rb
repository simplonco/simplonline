require 'test_helper'

class ExerciceTest < ActiveSupport::TestCase
  test "une_consigne_existe" do
    assert_equal "a", exercices(:one).consigne 
  end
end
