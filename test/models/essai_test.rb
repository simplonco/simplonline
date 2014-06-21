require 'test_helper'

class EssaiTest < ActiveSupport::TestCase
  test "un_essai_faux_renvoi_faux" do
    assert_equal false, essais(:two).run
  end

  test "un_essai_vrai_renvoi_vrai" do
    assert_equal true, essais(:three).run
  end

  test "un_essai_vrai_renvoi_un_statut_vrai" do
    assert_equal true, essais(:three).status
  end



end
