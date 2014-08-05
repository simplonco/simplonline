require 'test_helper'

class EssaiTest < ActiveSupport::TestCase

  test "valid factory" do
    assert_equal true, FactoryGirl.build(:essai).valid?
  end

  test "invalid without exercice" do
    assert_equal true, FactoryGirl.build(:essai, exercice: nil).invalid?
  end

  test "return a dossier" do
    essai = FactoryGirl.create(:essai)
    expected_dir = "#{Rails.root}/public/exercice/#{essai.exercice.id}/user/essai/#{essai.id}"
    assert_equal expected_dir, essai.dossier
  end
end
