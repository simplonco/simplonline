require 'test_helper'
require 'pry'

class EssaiTest < ActiveSupport::TestCase
  test "un_essai_faux_renvoi_faux" do
    assert_equal false, essais(:hello_world).run
  end

  test "un_essai_vrai_renvoi_vrai" do
    assert_equal true, essais(:hello_name).run
  end

  test "un_essai_vrai_renvoi_un_statut_vrai" do
    essais(:hello_name).run
    assert_equal true, essais(:hello_name).status
  end
  
  test "charge_un_essai" do
    assert_equal "#{Rails.root}/public/essais/2/essai2", essais(:hello_name).load_file
  end
end
